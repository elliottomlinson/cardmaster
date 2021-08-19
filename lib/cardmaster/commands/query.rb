require 'cardmaster'

module Cardmaster
  module Commands
    class Query < Cardmaster::Command
      include Arguments

      SUPPORTED_PARAMETERS = ["title"].freeze

      def call(args, _name)
        query_parameters = validate_parameters(named_arguments(args))

        if query_parameters.nil?
          puts Query.help
          return
        end

        results = Card::CatalogueAdapters::JsonCatalogueAdapter.new("data/card_catalogue")
          .printable_cards
          .select { |card_spec| matches_query(card_spec, query_parameters) }

        CLI::UI::Frame.open('Search Results') do
          if results.empty?
            puts CLI::UI.fmt "{{x}} No results found."
          end

          puts CLI::UI.fmt "{{v}} Found #{results.size} result(s)."
          results.each do |card_spec|
            pretty_print(card_spec)
          end
        end
      end

      def self.help
        "A dummy command.\nUsage: {{command:#{Cardmaster::TOOL_NAME} query --title=[card title]}}"
      end

      private

      def validate_parameters(query_parameters)
        if (invalid_parameters = query_parameters.keys.select { |key| !SUPPORTED_PARAMETERS.include?(key) }).size > 0
          puts "Invalid query parameters: #{invalid_parameters}"
          return
        end

        query_parameters
      end

      def matches_query(card_spec, query_parameters)
        match_if_present(query_parameters, "name", card_spec.title)
      end

      def match_if_present(parameters, parameter_name, value)
        parameters[parameter_name].nil? || parameters[parameter_name] == value
      end

      def pretty_print(card_spec)
        CLI::UI::Frame.open(card_spec.title, color: box_color(card_spec.tier)) {
          case card_spec.rules
          when Card::Models::SimpleRules
            puts "Rules: #{card_spec.rules.text}"
          when Card::Models::PassiveActiveRules
            puts "Passive: #{card_spec.rules.passive}"
            puts "Active: #{card_spec.rules.active}"
          else
            raise "Invalid Rule type #{card_spec.rules.class}"
          end
          puts "Flavour: #{card_spec.flavour}"
          puts "Art: #{card_spec.art_path}"
          puts "Tags: #{card_spec.tags.join(',')}"

        }
      end

      def box_color(tier)
        case tier
        when :gold
          :yellow
        when :grey
          :cyan
        else
          tier
        end
      end
    end
  end
end
