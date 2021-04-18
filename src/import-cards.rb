require "bundler/setup"
require_relative "tabletop_simulator/importers/card_importer.rb"
require_relative "tabletop_simulator/models/card.rb"

card_importer = TabletopSimulator::Importers::CardImporter.new

card = TabletopSimulator::Models::Card.from_template

# alter the card

card_importer.import(card)
