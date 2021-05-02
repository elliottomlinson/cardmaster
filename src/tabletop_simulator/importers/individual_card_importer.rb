require "fileutils"
require_relative "../modules.rb"

module TabletopSimulator
  module Importers
    class IndividualCardImporter
      include CardFormatTranslator
      include SavedObjectsManipulator

      BASE_PATH = %w(Cards).freeze
      INDIVIDUAL_CARDS_PATH = (BASE_PATH + %w(Individual)).freeze

      def initialize(*saved_object_args)
        initialize_directory_pointers(*saved_object_args)
      end

      def import(stored_cards)
        clear_saved_objects(INDIVIDUAL_CARDS_PATH)

        stored_cards.each do |stored_card|
          card = TabletopSimulator::Models::Object.new(translate_card(stored_card))

          save_individual_card(card, stored_card.spec.title)
        end
      end

      private

      def save_individual_card(card, name)
        save_card(card, name, INDIVIDUAL_CARDS_PATH)
      end

      def save_card(card, name, folders)
        save_file("#{name}.json", JSON.pretty_generate(card.to_h), folders)
      end
    end
  end
end
