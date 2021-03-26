require_relative "./templates.rb"
require_relative "./config.rb"
require 'csv'

# map handling variables
mapwidth = 50
mapheight = 50

# each map is a set of tiles saved to the same object
Dir.mkdir(MAP_SAVED_DIR) unless File.exists?(MAP_SAVED_DIR)


maps = Dir.children(MAP_GIT_DIR)
puts "found "+maps.length.to_s+" maps"

maps.each do |map|

  posX = 0
  posZ = 0

  mapdir = MAP_SAVED_DIR+"/"+map
  File.open(mapdir+".json","w") do |file|
    file.write MAPFILE_OPEN
    CSV.foreach(MAP_GIT_DIR+"/"+map).with_index do |row,rownum|
      if rownum < 50
        row.each do |tile|
          if tile != "0"
            file.write MAPFILE_ENTRY_OPEN % {
              posX:posX,
              posZ:posZ
            }
            file.write MAP_INDEX[tile.to_i-1]
            file.write MAPFILE_ENTRY_CLOSE
          end
          posX = posX+2
        end
        posX = 0
        posZ = posZ + 2
      end
    end
    file.write MAPFILE_CLOSE
    file.close
    puts "finished "+maps.to_s.tr('[""]', '')
  end
end
