require "json"

csv_filename = ARGV[0]
output_filename = ARGV[1]
folder_name = ARGV[2]

puts "converting #{csv_filename} into catalogue json..."

csv_file = File.read(ARGV[0])

tier_by_number = [
  "grey",
  "blue",
  "green",
  "red",
  "gold"
]

csv_file.split("\n")
cards = csv_file.split("\n").map do |row|
  row = row.split("\t")
  next if row[0] == "Title"
  next if row[0] == ""
  {
    "title": row[1],
    "upgrade": row[3],
    "tier": tier_by_number[row[0].to_i],
    "details": {
      "rules": row[2],
      "flavour": row[4],
      "image": "assets/core/card/illustration/#{row[1]}.png"
    }
  }
end.compact

final_json = {
  "folder": folder_name,
  "content": cards
}

File.write(output_filename, JSON.pretty_generate(final_json))
