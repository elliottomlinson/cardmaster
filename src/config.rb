# tabletop simulator saved object folder
# condsider implementing an option to choose if you're elliot or duncan
SAVED_OBJ_DIR = "/home/ellio/.local/share/Tabletop Simulator/Saves/Saved Objects"

# local
# will fix this to be compatible cross-platform
GIT_DIR = "/home/ellio/projects/rpcg"

# figurine import
CHAR_GIT_DIR = GIT_DIR+"/assets/char"
CHAR_SAVED_DIR = SAVED_OBJ_DIR+"/char"
CHAR_URL = "https://raw.githubusercontent.com/elliottomlinson/rpcg/master/assets/char/%{set}/%{name}"

# item import
ITEM_GIT_DIR = GIT_DIR+"/assets/item"
ITEM_SAVED_DIR = SAVED_OBJ_DIR+"/item"
ITEM_FACE_URL = "https://raw.githubusercontent.com/elliottomlinson/rpcg/master/assets/item/%{set}/%{name}"
ITEM_BACK_URL = "https://raw.githubusercontent.com/elliottomlinson/rpcg/master/assets/item/back/%{set}.png"

# map import
MAP_GIT_DIR = GIT_DIR+"/assets/map"
MAP_SAVED_DIR = SAVED_OBJ_DIR+"/map"
