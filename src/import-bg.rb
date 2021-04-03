require_relative "./templates.rb"
require_relative "./dirs.rb"
require "open-uri"
require "addressable"

# handling variables for Tabletop Simulator
scale=0.8
rotation = 180
rowsize = 16

# Each char folder is a set, e.g. greenhouse-wench
Dir.mkdir(BG_SAVED_DIR) unless File.exists?(BG_SAVED_DIR)
sets = Dir.children(BG_GIT_DIR)
puts "found "+sets.length.to_s+" background sets"

sets.each do |set|
  name = Dir.children(BG_GIT_DIR+"/"+set)
  setdir = BG_SAVED_DIR+"/"+set
  posZ = posX = 0

  File.open(setdir+".json","w") do |file|
  file.write BG_OPEN
  name.each_with_index do |name,i|
    url = BG_URL % {set:set,name:name}
    url = Addressable::URI.encode(url)

    file.write BG_ENTRY % {
      name:name.chomp(".png"),
      url:url,
      posZ:posZ,
      posX:posX,
      scale:scale,
      rotation:rotation
      }

      # figurine rows
      if posX>(4*rowsize-8)
        posX=0
        posZ=posZ-4
      else
        posX=posX+4
      end

      # thumbnail
      if i == 0
        File.open(setdir+".png", 'wb') do |thumbnail|
          thumbnail.write URI.open(url).read
          puts "done all backgrounds for "+set
        end
      end

    end
    file.write BG_CLOSE
    file.close
  end
end
puts "done all backgrounds"
