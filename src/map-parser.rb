require_relative "./templates.rb"

def tiledata(tile)

  hexes = ["000000", "1A1A1A", "2D2D2D", "424242", "656565", "878787", "C1C1C1", "D3D3D3", "E1E1E1", "FFFFFF", "cfe2f3", "9fc5e8", "6fa8dc", "3d85c6", "b6d7a8", "93c47d", "6aa84f", "38761d", "274e13", "18330b", "fff2cc", "ffe599", "ffd966", "f1c232", "bf9000", "7f6000", "7f5100", "7f3c00", "b69675", "caa472", "ead1dc", "d5a6bd", "c27ba0", "a64d79", "741b47", "4c1130", "f4cccc", "ea9999", "e06666", "cc0000", "990000", "660000", "d9d2e9", "b4a7d6", "8e7cc3", "674ea7", "351c75", "20124d", "c9daf8", "a4c2f4", "6d9eeb", "3c78d8", "1155cc", "1c4587"]
  mapkey = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "!","@","#"."$"."%","^","&","*","(",")","-","[","}"]


  tilehex = hexes[mapkey.index(tile)]

  return TILE_ADDRESS % { hex:tilehex }
end
