require 'cardmaster'

module Cardmaster
  module Commands
    class TabletopImport < Cardmaster::Command
      include Arguments

      SUPPORTED_PARAMETERS = ["title"].freeze
      DECK_CATALOGUE = File.join(__dir__, "../../../data/deck_catalogue.json")
      STORAGE_MANIFEST = File.join(__dir__, "../../../data/storage_manifest.json")
      TABLETOP_DIRECTORY_ENV_KEY = "TABLETOP_DIRECTORY"
      BASE_FOLDER = "cardmaster"

      def call(args, _name)
        tabletop_directory = ENV["TABLETOP_DIRECTORY"]
        storage_adaptor = Card::StorageAdapters::GitStorageAdapter.new(STORAGE_MANIFEST)
        deck_importers = [
          TabletopSimulator::Importers::CustomDeckImporter.new(DECK_CATALOGUE, tabletop_directory, BASE_FOLDER),
          TabletopSimulator::Importers::IndividualCardImporter.new(tabletop_directory, BASE_FOLDER),
          TabletopSimulator::Importers::TaggedDeckImporter.new(tabletop_directory, BASE_FOLDER)
        ]

        deck_importers.each { |importer| importer.import(storage_adaptor.stored_cards) }
      end

      def self.help
        "A dummy command.\nUsage: {{command:#{Cardmaster::TOOL_NAME} query --title=[card title]}}"
      end
    end
  end
end
