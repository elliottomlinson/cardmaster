# tabletop simulator saved object folder
# condsider implementing an option to choose if you're elliot or duncan
SAVED_OBJ_DIR = "/home/ellio/.local/share/Tabletop Simulator/Saves/Saved Objects"

# local
# will fix this to be compatible cross-platform
GIT_DIR = "/home/ellio/projects/rpcg"

# figurine import
CHAR_GIT_DIR = GIT_DIR+"/art/char"
CHAR_SAVED_DIR = SAVED_OBJ_DIR+"/char"
CHAR_URL = "https://github.com/elliottomlinson/rpcg/blob/master/art/char/%{set}/%{name}?raw=true"

# item import
ITEM_GIT_DIR = GIT_DIR+"/art/item"
ITEM_SAVED_DIR = SAVED_OBJ_DIR+"/item"
ITEM_FACE_URL = "https://github.com/elliottomlinson/rpcg/blob/master/art/item/%{set}/%{name}?raw=true"
ITEM_BACK_URL = "https://github.com/elliottomlinson/rpcg/blob/master/art/item/back/%{set}.png?raw=true"
