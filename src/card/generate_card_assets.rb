require_relative "./models.rb"
require_relative "./generators.rb"
require_relative "./catalogue_adapters.rb"

catalogue_adapter = Card::CatalogueAdapters::JsonCatalogueAdapter.new("data/card_catalogue.json")

puts catalogue_adapter.printable_cards

return

generator = Card::Generators::VipsBasic.new

generator.generate(Card::Models::MOCK_CARD_SPECIFICATION, "./test.png")
