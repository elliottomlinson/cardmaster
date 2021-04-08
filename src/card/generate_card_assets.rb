require_relative "./models.rb"
require_relative "./generators.rb"
require_relative "./catalogue_adapters.rb"
require_relative "./storage_adapters.rb"
require "tmpdir"

catalogue_adapter = Card::CatalogueAdapters::JsonCatalogueAdapter.new("data/card_catalogue.json")
generator = Card::Generators::VipsBasic.new
storage_adapter = Card::StorageAdapters::GitStorageAdapter.new

card_specs = catalogue_adapter.printable_cards

Dir.mktmpdir do |tmp_dir|
  printed_cards = card_specs.map.with_index do |card_spec, index|
    image_path = File.join(tmp_dir, "#{index}.png")

    generator.generate(Card::Models::MOCK_CARD_SPECIFICATION, image_path)

    Card::Models::PrintedCard.new(
      image_path,
      card_spec
    )
  end

  storage_adapter.save(printed_cards)
end

