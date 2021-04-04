require_relative "./models.rb"
require_relative "./generators.rb"

generator = Card::Generators::VipsBasic.new

generator.generate(Card::Models::MOCK_CARD_SPECIFICATION, "./test.png")
