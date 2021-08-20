require "fileutils"
require_relative "../modules.rb"

module TabletopSimulator
  module Importers
    class TaggedDeckImporter
      include CardFormatTranslator
      include SavedObjectsManipulator

      BASE_PATH = %w(Decks).freeze
      TAGGED_DECK_PATH = (BASE_PATH + %w(Tags)).freeze

      def initialize(*saved_object_args)
        initialize_directory_pointers(*saved_object_args)
      end

      def import(generated_cards)
        decks_by_tag = sort_by_tag(generated_cards).map do |tag, cards|
          [
            tag,
            TabletopSimulator::Models::Object.new(
              TabletopSimulator::Models::ObjectState.deck(
                nickname: tag,
                cards: translate_cards(cards)
              )
            )
          ]
        end.to_h

        decks_by_tag.each { |tag, deck| save_deck(deck, tag, TAGGED_DECK_PATH) }
      end

      private

      def sort_by_tag(generated_cards)
        generated_cards.each_with_object({}) do |generated_card, generated_cards_by_tag|
          generated_card.spec.tags.each do |tag|
            generated_cards_by_tag[tag] ||= []
            generated_cards_by_tag[tag].append(generated_card)
          end
        end
      end

      def save_deck(deck, name, folders)
        save_file("#{name}.json", JSON.pretty_generate(deck.to_h), folders)
      end
    end
  end
end
