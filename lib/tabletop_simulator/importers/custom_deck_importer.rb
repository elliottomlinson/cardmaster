require "fileutils"
require_relative "../modules.rb"

module TabletopSimulator
  module Importers
    class CustomDeckImporter
      include CardFormatTranslator
      include SavedObjectsManipulator

      BASE_PATH = %w(Decks).freeze
      CUSTOM_DECK_PATH = (BASE_PATH + %w(Custom)).freeze

      def initialize(deck_catalogue, *saved_object_args)
        raise "Deck catalogue at #{deck_catalogue} not found" unless File.exists?(deck_catalogue)
        @deck_catalogue = JSON.parse(File.read(deck_catalogue))
        initialize_directory_pointers(*saved_object_args)
      end

      def import(stored_cards)
        @deck_catalogue.each do |deck_catalogue|
          name = deck_catalogue["name"]
          tags = deck_catalogue["tags"]
          tiers = deck_catalogue["tiers"]
          min_count = deck_catalogue["min-count"]

          applicable_cards = stored_cards.select do |stored_card|
            intersecting_tags = stored_card.spec.tags & tags

            !intersecting_tags.empty? && tiers.include?(stored_card.spec.tier.to_s)
          end

          if applicable_cards.empty?
            puts "Warning: deck #{name} has no applicable cards"
            next
          end

          # Copy the deck until we hit the minimum length requirement
          unless min_count.nil?
            applicable_cards *= min_count/applicable_cards.length + 1
          end

          save_deck(
            TabletopSimulator::Models::Object.new(
              TabletopSimulator::Models::ObjectState.deck(
                nickname: name,
                cards: translate_cards(applicable_cards)
              )
            ),
            name,
            CUSTOM_DECK_PATH
          )
        end
      end

      private

      def sort_by_tag(stored_cards)
        stored_cards.each_with_object({}) do |generated_card, stored_cards_by_tag|
          generated_card.spec.tags.each do |tag|
            stored_cards_by_tag[tag] ||= []
            stored_cards_by_tag[tag].append(generated_card)
          end
        end
      end

      def save_deck(deck, name, folders)
        save_file("#{name}.json", JSON.pretty_generate(deck.to_h), folders)
      end
    end
  end
end
