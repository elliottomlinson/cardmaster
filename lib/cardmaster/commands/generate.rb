require 'cardmaster'

module Cardmaster
  module Commands
    class Generate < Cardmaster::Command
      include Arguments

      SUPPORTED_FLAGS = ["all"].freeze

      MANIFEST_PATH = "data/print_manifest.json"

      def call(args, _name)
        flags = flag_arguments(args)

        flags.each do |flag|
          unless SUPPORTED_FLAGS.include?(flag)
            puts "Unrecognized flag #{flag}"
            puts Generate.help

            return
          end
        end

        specified_cards = positional_arguments(args)

        print_count = 0
        Dir.mktmpdir do |tmp_dir|
          printed_cards = spec_diffs.map.with_index do |spec_diff, index|
            next if spec_diff[:old] == spec_diff[:new] && !flags.include?("all")
            next if specified_cards && !specified_cards.include?(spec_diff[:new].title)

            print_count += 1

            card_spec = spec_diff[:new]
            puts "Printing #{card_spec.title}..."

            image_path = File.join(tmp_dir, "#{index}.png")

            generator.generate(card_spec, image_path)

            Card::Models::PrintedCard.new(
              image_path,
              card_spec,
              card_backs[card_spec.tier]
            )
          end.compact

          if print_count == 0
            puts "Stored cards are up to date."
          else
            puts "Printed #{print_count} cards. Storing..."
            storage_adapter.save(printed_cards)
          end
          puts "All Finished."
        end
      end

      def self.help
        "A dummy command.\nUsage: {{command:#{Cardmaster::TOOL_NAME} query --title=[card title]}}"
      end

      private

      def spec_diffs
        return @spec_diffs if @spec_diffs

        stored_card_specs = storage_adapter.stored_cards.map(&:spec)
        card_specs = catalogue_adapter.printable_cards

        puts "Found #{stored_card_specs.length} stored cards..."
        puts "Found #{card_specs.length} cards specified in catalogue..."

        printed_by_title = stored_card_specs.each_with_object({}) do |card_spec, title_hash|
          title_hash[card_spec.title] = card_spec
        end

        specified_by_title = card_specs.each_with_object({}) do |card_spec, title_hash|
          title_hash[card_spec.title] = card_spec
        end

        stored_card_specs.map do |card_spec|
          if specified_by_title[card_spec.title].nil?
            puts "Deleting printed card missing from spec #{card_spec.title}..."
            storage_adapter.delete(card_spec.title)
          end
        end

        @spec_diffs = card_specs.map do |card_spec|
          {
            old: printed_by_title[card_spec.title],
            new: card_spec
          }
        end

      end

      def generator
        card_templates = ->(card_spec) do
          "assets/core/card/template/default.html"
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
