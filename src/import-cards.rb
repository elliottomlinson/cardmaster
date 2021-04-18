require "bundler/setup"
require_relative "tabletop_simulator/importers/card_importer.rb"
require_relative "tabletop_simulator/models/card.rb"
require_relative "card/storage_adapters.rb"

# todo centralize
saved_objects_folder = "/Users/duncanuszkay/Library/Tabletop Simulator/Saves/Saved Objects"
base_directory = "Cardmaster"

card_importer = TabletopSimulator::Importers::CardImporter.new(saved_objects_folder, base_directory)

storage_adapter = Card::StorageAdapters::GitStorageAdapter.new

printed_cards = storage_adapter.printed_cards

printed_cards.each do |printed_card|
  card_importer.import(printed_card)
end
