require_relative "./templates.rb"
require_relative "./config.rb"
require "open-uri"
require "addressable"

# Figurine handling variables for Tabletop Simulator
scale = 0.7
rowsize = 16
imgscale = 2
rotation = 90

# Each char folder is a set, e.g. greenhouse-wench
Dir.mkdir(CHAR_SAVED_DIR) unless File.exists?(CHAR_SAVED_DIR)
sets = Dir.children(CHAR_GIT_DIR)
puts "found "+sets.length.to_s+" character sets"

sets.each do |set|
  name = Dir.children(CHAR_GIT_DIR+"/"+set)
  setdir = CHAR_SAVED_DIR+"/"+set
  posX = posZ = 0

  File.open(setdir+".json","w") do |file|
  file.write CHARFILE_OPEN
  name.each_with_index do |name,i|
    url = CHAR_URL % {set:set,name:name}
    url = Addressable::URI.encode(url)

    file.write CHARFILE_ENTRY % {
      name:name.chomp(".png"),
      url:url,
      posX:posX,
      posZ:posZ,
      scale:scale,
      imgscale:imgscale,
      rotation:rotation
      }

      # figurine rows
      if posZ<(-2*rowsize+4)
        posZ=0
        posX=posX-2
      else
        posZ=posZ-2
      end

      # thumbnail
      if i == 0
        File.open(setdir+".png", 'wb') do |thumbnail|
          thumbnail.write URI.open(url).read
          puts "done character set "+set
        end
      end

    end
    file.write CHARFILE_CLOSE
    file.close
  end
end
