require_relative "./models.rb"
require_relative "./generators.rb"
require_relative "./catalogue_adapters.rb"
require_relative "./storage_adapters.rb"
require "tmpdir"

card_backs = {
  grey: "assets/core/card/back/grey.png",
  blue: "assets/core/card/back/blue.png",
  green: "assets/core/card/back/green.png",
  red: "assets/core/card/back/red.png",
  gold: "assets/core/card/back/gold.png"
}.freeze

diff = ARGV.include?("--diff")
if diff
  puts "Printing new and updated cards."
else
  puts "Reprinting all cards."
end

catalogue_adapter = Card::CatalogueAdapters::JsonCatalogueAdapter.new("data/card_catalogue.json")
generator = Card::Generators::VipsBasic.new
storage_adapter = Card::StorageAdapters::GitStorageAdapter.new

printed_card_specs = storage_adapter.printed_cards.map(&:spec)
card_specs = catalogue_adapter.printable_cards

puts "Found #{printed_card_specs.length} stored cards..."
puts "Found #{card_specs.length} cards specified in catalogue..."

printed_by_title = printed_card_specs.each_with_object({}) do |card_spec, title_hash|
  title_hash[card_spec.title] = card_spec
end

spec_diffs = card_specs.map do |card_spec|
  {
    old: printed_by_title[card_spec.title],
    new: card_spec
  }
end

print_count = 0
Dir.mktmpdir do |tmp_dir|
  printed_cards = spec_diffs.map.with_index do |spec_diff, index|
    next if spec_diff[:old] == spec_diff[:new] && diff

    print_count += 1

    card_spec = spec_diff[:new]
    puts "Printing #{card_spec.title}..."

    image_path = File.join(tmp_dir, "#{index}.png")

    generator.generate(card_spec, image_path)

    Card::Models::PrintedCard.new(
      image_path,
      card_spec,
      card_backs[card_spec.tier]
    )
  end.compact

  if print_count == 0
    puts "Stored cards are up to date."
  else
    puts "Printed #{print_count} cards. Storing..."
    storage_adapter.save(printed_cards)
  end
  puts "All Finished."
end
