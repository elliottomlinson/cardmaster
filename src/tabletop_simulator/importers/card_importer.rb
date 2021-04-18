require "fileutils"

module TabletopSimulator
  # todo: centralize this
  module Importers
    class CardImporter
      BASE_PATH = %w(Cards).freeze
      INDIVIDUAL_CARDS_PATH = (BASE_PATH + %w(Individual)).freeze

      def initialize(saved_objects_folder, base_directory)
        @saved_objects_folder = saved_objects_folder
        @base_directory = base_directory
      end

      def import(printed_card)
        card = imprint(
          TabletopSimulator::Models::Card.from_template,
          printed_card
        )

        save_individual_card(card)
      end

      private

      def imprint(template_card, printed_card)
        template_card.name = printed_card.spec.title
        template_card.front_image_url = printed_card.image_url

        template_card
      end

      def save_individual_card(card)
        save_card(card, INDIVIDUAL_CARDS_PATH)
      end

      def save_card(card, folders)
        dir_path = path_in_saved_objects(folders)
        FileUtils.mkdir_p(dir_path)

        path = File.join(dir_path, "#{card.name}.json")
        File.write(path, card.to_json)
      end

      def path_in_saved_objects(folders)
        File.join(@saved_objects_folder, @base_directory, folders)
      end
    end
  end
end
