require "bundler/setup"
require_relative "tabletop_simulator/importers/card_importer.rb"
require_relative "tabletop_simulator/models/card.rb"

# todo centralize
saved_objects_folder = "/Users/duncanuszkay/Library/Tabletop Simulator/Saves/Saved Objects"
base_directory = "Cardmaster"

card_importer = TabletopSimulator::Importers::CardImporter.new(saved_objects_folder, base_directory)

card = TabletopSimulator::Models::Card.from_template

# alter the card

card_importer.import(card)
