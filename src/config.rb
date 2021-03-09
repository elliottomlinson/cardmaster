# tabletop simulator saved object folder
SAVED_OBJ_DIR = "/home/ellio/.local/share/Tabletop Simulator/Saves/Saved Objects"

# local
GIT_DIR = File.expand_path("..", Dir.pwd)


# figurine import
CHAR_GIT_DIR = GIT_DIR+"/art/char"
CHAR_SAVED_DIR = SAVED_OBJ_DIR+"/char"
CHAR_URL = "https://github.com/elliottomlinson/rpg-art/blob/master/art/char/%{set}/%{name}?raw=true"
