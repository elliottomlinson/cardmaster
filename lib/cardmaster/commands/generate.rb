require 'cardmaster'

module Cardmaster
  module Commands
    class Generate < Cardmaster::Command
      include Arguments

      SUPPORTED_FLAGS = ["force", "all"].freeze

      MANIFEST_PATH = "data/storage_manifest.json"
      CARD_BACKS = {
        grey: "res/card/back/grey.png",
        blue: "res/card/back/blue.png",
        green: "res/card/back/green.png",
        red: "res/card/back/red.png",
        gold: "res/card/back/gold.png"
      }.freeze
      DEFAULT_TEMPLATE = "res/card/template/default.html"


      def call(args, _name)
        flags = flag_arguments(args)

        flags.each do |flag|
          unless SUPPORTED_FLAGS.include?(flag)
            puts "Unrecognized flag #{flag}"
            puts Generate.help

            return
          end
        end

        @specified_cards = positional_arguments(args)

        if flags.include?("all")
          @all = true
        elsif @specified_cards.length == 0
          puts CLI::UI.fmt self.class.help
          return
        end

        CLI::UI::Frame.open("Generate", color: :cyan) do
          if flags.include?("force")
            puts CLI::UI.fmt "{{*}} Running in force mode. All specified cards will be generated"
            @force = true
          end

          spec_diffs = catalogue_info

          Dir.mktmpdir do |tmp_dir|
            generated_count, generated_cards = generate_cards(spec_diffs, tmp_dir)

            if generated_count > 0
              store_cards(generated_cards)
            end
          end

          puts CLI::UI.fmt "{{v}} Finished"
        end
      end

      def self.help
        "Generates and stores the cards in your cardmaster catalogue.\nUsage: {{command:#{Cardmaster::TOOL_NAME} generate}} [card title,...] [--force] [--all]\nExample: {{command:#{Cardmaster::TOOL_NAME} generate}} Foo Bar --force"
      end

      private

      def catalogue_info
        CLI::UI::Frame.open("Retrieving Catalogue Info", color: :blue) do
          stored_card_specs = storage_adapter.stored_cards.map(&:spec)
          card_specs = catalogue_adapter.card_specifications

          puts "Cards recorded in storage manifest: #{stored_card_specs.length}"
          puts "Cards specified in catalogue: #{card_specs.length}"

          if @force
            spec_diffs = card_specs.map { |card_spec| { old: nil, new: card_spec } }
          else
            specification_diff_spinner = CLI::UI::SpinGroup.new
            specification_diff_spinner.add('Calculating Specification Diff...') { |spinner| spec_diffs = calculate_spec_diffs(stored_card_specs, card_specs) }
            specification_diff_spinner.wait
          end

          spec_diffs
        end
      end

      def calculate_spec_diffs(stored_card_specs, card_specs)
        generated_by_title = stored_card_specs.each_with_object({}) do |card_spec, title_hash|
          title_hash[card_spec.title] = card_spec
        end

        specified_by_title = card_specs.each_with_object({}) do |card_spec, title_hash|
          title_hash[card_spec.title] = card_spec
        end

        stored_card_specs.map do |card_spec|
          if specified_by_title[card_spec.title].nil?
            puts "Deleting generated card missing from spec #{card_spec.title}..."
            storage_adapter.delete(card_spec.title)
          end
        end

        @spec_diffs = card_specs.map do |card_spec|
          {
            old: generated_by_title[card_spec.title],
            new: card_spec
          }
        end
      end

      def generate_cards(spec_diffs, target_directory)
        CLI::UI::Frame.open("Generating Cards", color: :blue) do
          skipped_matching = false
          generated_count = 0

          generate_spinners = CLI::UI::SpinGroup.new
          generated_cards = spec_diffs.map.with_index do |spec_diff, index|
            next unless @specified_cards.empty? || @specified_cards.include?(spec_diff[:new].title)

            if spec_diff[:old] == spec_diff[:new]
              puts CLI::UI.fmt "{{v}} Card #{spec_diff[:new].title} is already up to date in storage manifest. Skipping..."
              skipped_matching = true
              next
            end

            generated_count += 1

            card_spec = spec_diff[:new]
            image_path = File.join(target_directory, "#{index}.png")

            generate_spinners.add("Generating #{card_spec.title}...") { |spinner| generator.generate(card_spec, image_path) }
            generate_spinners.wait

            Card::Models::GeneratedCard.new(
              image_path,
              card_spec,
              CARD_BACKS[card_spec.tier]
            )
          end.compact

          puts CLI::UI.fmt "{{*}} Generated #{generated_count} cards."

          if skipped_matching == true
            CLI::UI::Frame.open("Notice", color: :yellow) do
              puts CLI::UI.fmt "Some cards were not generated since their spec hadn't changed since this command was last run."
              puts CLI::UI.fmt "To force all specified cards to generate, use the --force flag."
            end
          end

          [generated_count, generated_cards]
        end
      end

      def store_cards(cards)
        CLI::UI::Frame.open("Storing Cards", color: :blue) do
          storage_spinner = CLI::UI::SpinGroup.new
          storage_spinner.add("Storing #{cards.length} cards...") { |spinner| storage_adapter.save(cards) }
          storage_spinner.wait
        end
      end

      def generator
        card_templates = ->(card_spec) do
          DEFAULT_TEMPLATE
        end
        @generator ||= Card::Generators::IMGKitBasic.new(card_templates, [])
      end

      def catalogue_adapter
        @catalogue_adapter ||= Card::CatalogueAdapters::JsonCatalogueAdapter.new("data/card_catalogue")
      end

      def storage_adapter
        @storage_adapter ||= Card::StorageAdapters::GitStorageAdapter.new(MANIFEST_PATH)
      end
    end
  end
end
