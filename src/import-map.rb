require_relative "./templates.rb"
require_relative "./dirs.rb"
require 'csv'

# map handling variables
mapwidth = 50
mapheight = 50
sale = 0.99

#decoding sheet
hexes = ["000000", "1A1A1A", "2D2D2D", "424242", "656565", "878787", "C1C1C1", "D3D3D3", "E1E1E1", "FFFFFF", "cfe2f3", "9fc5e8", "6fa8dc", "3d85c6", "b6d7a8", "93c47d", "6aa84f", "38761d", "274e13", "18330b", "fff2cc", "ffe599", "ffd966", "f1c232", "bf9000", "7f6000", "7f5100", "7f3c00", "b69675", "caa472", "ead1dc", "d5a6bd", "c27ba0", "a64d79", "741b47", "4c1130", "f4cccc", "ea9999", "e06666", "cc0000", "990000", "660000", "d9d2e9", "b4a7d6", "8e7cc3", "674ea7", "351c75", "20124d", "c9daf8", "a4c2f4", "6d9eeb", "3c78d8", "1155cc", "1c4587"]
mapkey = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "!","@","#","$","%","^","&","*","(",")","-","[","}"]
backurl = "https://raw.githubusercontent.com/elliottomlinson/rpcg/master/assets/core/tile/back.png"


ADDRESS = "\"ImageURL\":\"https://dummyimage.com/%{size}x100/%{hex}/&text=%{text}\",\"ImageSecondaryURL\":\"%{backurl}\","


# each map is a set of tiles saved to the same object
Dir.mkdir(MAP_SAVED_DIR) unless File.exists?(MAP_SAVED_DIR)


maps = Dir.children(MAP_GIT_DIR)
puts "found "+maps.length.to_s+" maps"

maps.each do |map|

  posX = 0
  posZ = 0

  mapdir = MAP_SAVED_DIR+"/"+map
  File.open(mapdir+".json","w") do |file|
    file.write MAP_OPEN
    CSV.foreach(MAP_GIT_DIR+"/"+map).with_index do |row,rownum|
      if rownum < 50
        row.each do |tile|
          if tile != "0"
            marker = mapkey.index(tile)
            hex = hexes[marker]
            file.write MAP_ENTRY % {
              posX:posX,
              posZ:posZ,
              scale:scale,
              size:100,
              hex:hex,
              text:"\%99"
            }
          end
          posX = posX-2
        end
        posX = 0
        posZ = posZ - 2
      end
    end
    file.write MAP_CLOSE
    file.close
    puts "finished "+maps.to_s.tr('[""]', '')
  end
end
puts "done all maps"
