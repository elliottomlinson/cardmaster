require_relative "./models.rb"
require_relative "./generators.rb"
require_relative "./catalogue_adapters.rb"
require_relative "./storage_adapters.rb"
require "tmpdir"

catalogue_adapter = Card::CatalogueAdapters::JsonCatalogueAdapter.new("data/card_catalogue.json")
generator = Card::Generators::VipsBasic.new
storage_adapter = Card::StorageAdapters::GitStorageAdapter.new

card_backs = {
  grey: "assets/core/card/back/grey.png",
  blue: "assets/core/card/back/blue.png",
  green: "assets/core/card/back/green.png",
  red: "assets/core/card/back/red.png",
  gold: "assets/core/card/back/gold.png"
}

card_specs = catalogue_adapter.printable_cards

Dir.mktmpdir do |tmp_dir|
  printed_cards = card_specs.map.with_index do |card_spec, index|
    puts "Printing #{card_spec.title}"
    image_path = File.join(tmp_dir, "#{index}.png")

    generator.generate(card_spec, image_path)

    Card::Models::PrintedCard.new(
      image_path,
      card_spec,
      card_backs[card_spec.tier]
    )
  end.compact

  storage_adapter.save(printed_cards)
end

