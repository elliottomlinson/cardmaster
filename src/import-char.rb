require_relative "./templates.rb"
require_relative "./dirs.rb"
require "open-uri"
require "addressable"

# Figurine handling variables for Tabletop Simulator
scale = 0.7
rowsize = 16
imgscale = 2
rotation = 0

# Each char folder is a set, e.g. greenhouse-wench
Dir.mkdir(CHAR_SAVED_DIR) unless File.exists?(CHAR_SAVED_DIR)
sets = Dir.children(CHAR_GIT_DIR)
puts "found "+sets.length.to_s+" character sets"

sets.each do |set|
  name = Dir.children(CHAR_GIT_DIR+"/"+set)
  setdir = CHAR_SAVED_DIR+"/"+set
  posZ = posX = 0

  File.open(setdir+".json","w") do |file|
  file.write CHAR_OPEN
  name.each_with_index do |name,i|
    url = CHAR_URL % {set:set,name:name}
    url = Addressable::URI.encode(url)

    file.write CHAR_ENTRY % {
      name:name.chomp(".png"),
      url:url,
      posZ:posZ,
      posX:posX,
      scale:scale,
      imgscale:imgscale,
      rotation:rotation
      }

      # figurine rows
      if posX>(2*rowsize-4)
        posX=0
        posZ=posZ-2
      else
        posX=posX+2
      end

      # thumbnail
      if i == 0
        File.open(setdir+".png", 'wb') do |thumbnail|
          thumbnail.write URI.open(url).read
          puts "done character set "+set
        end
      end

    end
    file.write CHAR_CLOSE
    file.close
  end
end
puts "done all char sets"
