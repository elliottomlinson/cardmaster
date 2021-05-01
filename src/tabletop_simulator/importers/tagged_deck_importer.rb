require "fileutils"
require_relative "../card_format_translator.rb"

module TabletopSimulator
  # todo: centralize this
  module Importers
    class TaggedDeckImporter
      include CardFormatTranslator

      BASE_PATH = %w(Decks).freeze
      TAGGED_DECK_PATH = (BASE_PATH + %w(Tags)).freeze

      def initialize(saved_objects_folder, base_directory)
        @saved_objects_folder = saved_objects_folder
        @base_directory = base_directory
      end

      def import(printed_cards)
        puts printed_cards.map { |p| p.image_url }
        decks_by_tag = sort_by_tag(printed_cards).map do |tag, cards|
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

      def sort_by_tag(printed_cards)
        printed_cards.each_with_object({}) do |printed_card, printed_cards_by_tag|
          printed_card.spec.tags.each do |tag|
            printed_cards_by_tag[tag] ||= []
            printed_cards_by_tag[tag].append(printed_card)
          end
        end
      end

      def save_deck(deck, name, folders)
        dir_path = path_in_saved_objects(folders)
        FileUtils.mkdir_p(dir_path)

        path = File.join(dir_path, "#{name}.json")
        File.write(path, JSON.pretty_generate(deck.to_h))
      end

      def path_in_saved_objects(folders)
        File.join(@saved_objects_folder, @base_directory, folders)
      end
    end
  end
end
