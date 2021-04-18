require "fileutils"

module TabletopSimulator
  # todo: centralize this
  TABLETOP_SAVE_OBJECTS = "/Users/duncanuszkay/Library/Tabletop Simulator/Saves/Saved Objects"
  module Importers
    class CardImporter
      BASE_PATH = %w(cardmaster cards).freeze
      INDIVIDUAL_CARD_PATH = BASE_PATH + %w(individual)

      def import(card)
        save_individual_card(card)
      end

      private

      def save_individual_card(card)
        save_card(card, INDIVIDUAL_CARD_PATH)
      end

      def save_card(card, folders)
        dir_path = File.join(folders.prepend(TABLETOP_SAVE_OBJECTS))
        FileUtils.mkdir_p(dir_path)

        path = File.join(dir_path, "#{card.name}.json")
        File.write(path, card.to_json)
      end
    end
  end
end
