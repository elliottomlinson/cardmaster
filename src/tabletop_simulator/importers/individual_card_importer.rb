require "fileutils"
require_relative "../card_format_translator.rb"

module TabletopSimulator
  module Importers
    class IndividualCardImporter
      include CardFormatTranslator

      BASE_PATH = %w(Cards).freeze
      INDIVIDUAL_CARDS_PATH = (BASE_PATH + %w(Individual)).freeze

      def initialize(saved_objects_folder, base_directory)
        @saved_objects_folder = saved_objects_folder
        @base_directory = base_directory
      end

      def import(printed_card)
        card = TabletopSimulator::Models::Object.new(translate_card(printed_card))

        save_individual_card(card, printed_card.spec.title)
      end

      private

      def save_individual_card(card, name)
        save_card(card, name, INDIVIDUAL_CARDS_PATH)
      end

      def save_card(card, name, folders)
        dir_path = path_in_saved_objects(folders)
        FileUtils.mkdir_p(dir_path)

        path = File.join(dir_path, "#{name}.json")
        File.write(path, JSON.pretty_generate(card.to_h))
      end

      def path_in_saved_objects(folders)
        File.join(@saved_objects_folder, @base_directory, folders)
      end
    end
  end
end
