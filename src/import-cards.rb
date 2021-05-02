require "bundler/setup"
require_relative "tabletop_simulator/importers/individual_card_importer.rb"
require_relative "card/storage_adapters.rb"

# todo centralize
TABLETOP_SAVED_OBJECTS_FOLDER_ENV_KEY = "TABLETOP_SAVED_OBJECTS_FOLDER"

saved_objects_folder = ENV[TABLETOP_SAVED_OBJECTS_FOLDER_ENV_KEY]
raise "You need to specify your saved objects folder in your env under the #{TABLETOP_SAVED_OBJECTS_FOLDER_ENV_KEY} key" unless saved_objects_folder

base_directory = "Cardmaster"

individual_card_importer = TabletopSimulator::Importers::IndividualCardImporter.new(saved_objects_folder, base_directory)

storage_adapter = Card::StorageAdapters::GitStorageAdapter.new

stored_cards = storage_adapter.stored_cards

stored_cards.each do |stored_card|
  individual_card_importer.import(stored_card)
end
