require_relative "./templates.rb"
require_relative "./dirs.rb"
require "open-uri"
require "addressable"

# handling variables for Tabletop Simulator
rotation = 180

#decoding sheet
hexes = ["000000", "1A1A1A", "2D2D2D", "424242", "656565", "878787", "C1C1C1", "D3D3D3", "E1E1E1", "FFFFFF", "cfe2f3", "9fc5e8", "6fa8dc", "3d85c6", "b6d7a8", "93c47d", "6aa84f", "38761d", "274e13", "18330b", "fff2cc", "ffe599", "ffd966", "f1c232", "bf9000", "7f6000", "7f5100", "7f3c00", "b69675", "caa472", "ead1dc", "d5a6bd", "c27ba0", "a64d79", "741b47", "4c1130", "f4cccc", "ea9999", "e06666", "cc0000", "990000", "660000", "d9d2e9", "b4a7d6", "8e7cc3", "674ea7", "351c75", "20124d", "c9daf8", "a4c2f4", "6d9eeb", "3c78d8", "1155cc", "1c4587"]
mapkey = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]


# Each char folder is a set, e.g. greenhouse-wench
Dir.mkdir(STATED_SAVED_DIR) unless File.exists?(STATED_SAVED_DIR)
sets = Dir.children(STATED_GIT_DIR)
puts "found "+sets.length.to_s+" stated items"

sets.each do |set|
  name = Dir.children(STATED_GIT_DIR+"/"+set)
  setdir = STATED_SAVED_DIR+"/"+set

  File.open(setdir+".json","w") do |file|
    file.write STATEDFILE_OPEN
    name.each_with_index do |name,i|
      url = STATED_URL % {set:set,name:name}
      url = Addressable::URI.encode(url)

      if i == 0
        file.write STATEDFILE_FIRST_ENTRY % {
          name:name.chomp(".png"),
          url:url,
          rotation:rotation
        }
        File.open(setdir+".png", 'wb') do |thumbnail|
          thumbnail.write URI.open(url).read
          thumbnail.close
        end
      elsif i > 0
        file.write STATEDFILE_ENTRY % {
          name:name.chomp(".png"),
          statenum:i+1,
          url:url,
          rotation:rotation
        }
      end
    end
    file.write STATEDFILE_CLOSE
    file.close
    puts "done "+set.to_s
  end
end
puts "done all stated items"
