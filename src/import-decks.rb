require "bundler/setup"
require_relative "tabletop_simulator/importers/tagged_deck_importer.rb"
require_relative "card/storage_adapters.rb"

# todo centralize
TABLETOP_SAVED_OBJECTS_FOLDER_ENV_KEY = "TABLETOP_SAVED_OBJECTS_FOLDER"

saved_objects_folder = ENV[TABLETOP_SAVED_OBJECTS_FOLDER_ENV_KEY]
raise "You need to specify your saved objects folder in your env under the #{TABLETOP_SAVED_OBJECTS_FOLDER_ENV_KEY} key" unless saved_objects_folder

base_directory = "Cardmaster"

storage_adapter = Card::StorageAdapters::GitStorageAdapter.new
tagged_deck_importer = TabletopSimulator::Importers::TaggedDeckImporter.new(saved_objects_folder, base_directory)

stored_cards = storage_adapter.stored_cards

tagged_deck_importer.import(stored_cards)
