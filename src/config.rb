# tabletop simulator saved object folder
SAVED_OBJ_DIR = "/home/ellio/.local/share/Tabletop Simulator/Saves/Saved Objects"

# local
# will fix this to be compatible with all machines
GIT_DIR = "/home/ellio/projects/rpg-art"

# figurine import
CHAR_GIT_DIR = GIT_DIR+"/art/char"
CHAR_SAVED_DIR = SAVED_OBJ_DIR+"/char"
CHAR_URL = "https://github.com/elliottomlinson/rpg-art/blob/master/art/char/%{set}/%{name}?raw=true"

# item import
ITEM_GIT_DIR = GIT_DIR+"/art/item"
ITEM_SAVED_DIR = SAVED_OBJ_DIR+"/item"
ITEM_FACE_URL = "https://github.com/elliottomlinson/rpg-art/blob/master/art/item/%{set}/%{name}?raw=true"
ITEM_BACK_URL = "https://github.com/elliottomlinson/rpg-art/blob/master/art/item/back/%{set}.png?raw=true"
