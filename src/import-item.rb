require_relative "./templates.rb"
require_relative "./dirs.rb"
require "open-uri"
require "addressable"

# card handling variables
rowsize = 16
cardnum=22
scale=1
rotation=90

# Each ITEM folder is a set, e.g. greenhouse-wench
Dir.mkdir(ITEM_SAVED_DIR) unless File.exists?(ITEM_SAVED_DIR)
sets = Dir.children(ITEM_GIT_DIR)
puts "found "+sets.length.to_s+" item sets"


sets.each do |set|

  name = Dir.children(ITEM_GIT_DIR+"/"+set)
  setdir = ITEM_SAVED_DIR+"/"+set
  posZ = posX = 0

  backurl = ITEM_BACK_URL % {set:set}
  backurl = Addressable::URI.encode(backurl)

  File.open(setdir+".json","w") do |file|
  file.write ITEM_OPEN
  name.each_with_index do |name,i|

    cardnum = cardnum+1

    faceurl = ITEM_FACE_URL % {set:set,name:name}
    faceurl = Addressable::URI.encode(faceurl)

    file.write ITEM_ENTRY % {

      cardnum:cardnum,
      posZ:posZ,
      posX:posX,
      roation:rotation,
      name:name.chomp(".png"),
      scale:scale,
      rotation:rotation,
      faceurl:faceurl,
      backurl:backurl,
      }

      # item card rows
      if posX>(2*rowsize-4)
        posX=0
        posZ=posZ-2
      else
        posX=posX+2
      end

      # thumbnail
      if i == 0
        File.open(setdir+".png", 'wb') do |thumbnail|
          thumbnail.write URI.open(backurl).read
          puts "done item set "+set
        end
      end

    end
    file.write ITEM_CLOSE
    file.close
  end
end
puts "done all items"
