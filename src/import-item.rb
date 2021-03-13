require_relative "./templates.rb"
require_relative "./config.rb"
require "open-uri"
require "addressable"

# card handling variables
rowsize = 16
cardnum=2000
scale=1
rotation=90


# Each ITEM folder is a set, e.g. greenhouse-wench
Dir.mkdir(ITEM_SAVED_DIR) unless File.exists?(ITEM_SAVED_DIR)
sets = Dir.children(ITEM_GIT_DIR)
puts "found "+sets.length.to_s+" item sets"


sets.each do |set|
  cardnum=cardnum+1000

  name = Dir.children(ITEM_GIT_DIR+"/"+set)
  setdir = ITEM_SAVED_DIR+"/"+set
  posX = posZ = 0

  cardbackurl = ITEM_BACK_URL % {set:set}
  cardbackurl = Addressable::URI.encode(cardbackurl)

  File.open(setdir+".json","w") do |file|
  file.write ITEMFILE_OPEN
  name.each_with_index do |name,i|

    cardnum = cardnum+1

    cardfronturl = ITEM_FACE_URL % {set:set,name:name}
    cardfronturl = Addressable::URI.encode(cardfronturl)

    file.write ITEMFILE_ENTRY % {

      cardnum:cardnum,
      posX:posX,
      posZ:posZ,
      roation:rotation,
      name:name.chomp(".png"),
      scale:scale,
      rotation:rotation,
      cardfronturl:cardfronturl,
      cardbackurl:cardbackurl,
      }

      # item card rows
      if posZ<(-2*rowsize+4)
        posZ=0
        posX=posX-2
      else
        posZ=posZ-2
      end

      # thumbnail
      if i == 0
        File.open(setdir+".png", 'wb') do |thumbnail|
          thumbnail.write URI.open(cardfronturl).read
          puts "done item set "+set
        end
      end

    end
    file.write ITEMFILE_CLOSE
    file.close
  end
end
