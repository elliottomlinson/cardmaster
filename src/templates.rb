require_relative "./dirs.rb"

# i'm certain this is a major rookie move
CHARFILE_OPEN = "{\"ObjectStates\":["
CHARFILE_ENTRY = "
    {
      \"Name\": \"Figurine_Custom\",
      \"Nickname\": \"%{name}\",
      \"CustomImage\":
      {
        \"ImageURL\": \"%{url}\",
        \"ImageSecondaryURL\": \"%{url}\",
        \"ImageScalar\": %{imgscale},
      },
      \"Transform\":
      {
        \"posX\": %{posX},
        \"posY\": 0,
        \"posZ\": %{posZ},
        \"scaleX\": %{scale},
        \"scaleY\": %{scale},
        \"rotY\": %{rotation},
        \"scaleZ\": %{scale}

      },
      \"ColorDiffuse\": {
        \"r\": 1,
        \"g\": 1,
        \"b\": 1
      },
    },"

CHARFILE_CLOSE = "]}"

# here we go again
ITEMFILE_OPEN = "{\"ObjectStates\":["
ITEMFILE_ENTRY = "
{
  \"Name\": \"CardCustom\",
  \"Transform\": {
    \"posX\": %{posX},
    \"posZ\": %{posZ},
    \"rotY\": %{rotation},
    \"scaleX\": %{scale},
    \"scaleY\": %{scale},
    \"scaleZ\": %{scale}
  },
  \"Nickname\": \"%{name}\",
  \"Description\": \"\",
  \"GMNotes\": \"\",
  \"ColorDiffuse\": {
    \"r\": 0.713235259,
    \"g\": 0.713235259,
    \"b\": 0.713235259
  },
  \"CardID\": %{cardnum}00,
  \"SidewaysCard\": false,
  \"CustomDeck\": {
    \"%{cardnum}\": {
      \"FaceURL\": \"%{cardfronturl}\",
      \"BackURL\": \"%{cardbackurl}\",
      \"NumWidth\": 1,
      \"NumHeight\": 1,
      \"BackIsHidden\": true,
      \"UniqueBack\": false,
      \"Type\": 0
    }
  },
},"
ITEMFILE_CLOSE = "]}"

# map time
MAPFILE_OPEN = "{\"ObjectStates\":["
MAPFILE_ENTRY_OPEN = "{
  \"Name\": \"Custom_Tile\",
  \"Transform\": {
    \"posX\": %{posX},
    \"posY\": 0,
    \"posZ\": %{posZ},
    \"rotX\": 0,
    \"rotY\": 0,
    \"rotZ\": 0,
    \"scaleX\": 0.98,
    \"scaleY\": 1.0,
    \"scaleZ\": 0.98
  },
  \"Nickname\": \"\",
  \"ColorDiffuse\": {
    \"r\": 0.165505171,
    \"g\": 0.165505171,
    \"b\": 0.165505171
  },
  \"GridProjection\": true,
  \"CustomImage\": {"


    TILE_ADDRESS = "\"ImageURL\":\"https://dummyimage.com/100x100/%{hex}/&text=%99\",\"ImageSecondaryURL\":\"http://cloud-3.steamusercontent.com/ugc/1724289762888315581/D7EB9601E8B2222A621D79112318607716AB2967/\","

MAPFILE_ENTRY_CLOSE = "        \"ImageScalar\": 1.0,
        \"WidthScale\": 0.0,
        \"CustomTile\": {
          \"Type\": 0,
          \"Thickness\": 0.1,
          \"Stackable\": false,
          \"Stretch\": false
        }
      },
      \"LuaScript\": \"\",
      \"LuaScriptState\": \"\",
      \"XmlUI\": \"\"
    },"

MAPFILE_CLOSE = "]}"

#backgrounds
BGFILE_OPEN = "{\"ObjectStates\":["
BGFILE_ENTRY = "    {
      \"Name\": \"Custom_Token\",
      \"Transform\": {
        \"posX\": %{posX},
        \"posY\": 0,
        \"posZ\": %{posZ},
        \"rotX\": %{rotation},
        \"rotY\": 0,
        \"rotZ\": 0,
        \"scaleX\": 0.98,
        \"scaleY\": 0.2,
        \"scaleZ\": 0.98
      },
      \"Nickname\": \"%{name}\",
      \"CustomImage\": {
        \"ImageURL\": \"%{url}\",
      },
    },"
BGFILE_CLOSE = "]}"


#STATED
STATEDFILE_OPEN = "{\"ObjectStates\":["

STATEDFILE_FIRST_ENTRY = "    {
      \"Name\": \"Custom_Token\",
      \"Transform\": {
        \"posX\": 0,
        \"posY\": 0,
        \"posZ\": 0,
        \"rotX\": %{rotation},
        \"rotY\": 0,
        \"rotZ\": 0,
        \"scaleX\": 0.98,
        \"scaleY\": 0.2,
        \"scaleZ\": 0.98
      },
      \"Nickname\": \"%{name}\",
      \"CustomImage\": {
        \"ImageURL\": \"%{url}\",
      },
    \"LuaScript\": \"\",
      \"LuaScriptState\": \"\",
      \"XmlUI\": \"\",
      \"States\": {"

STATEDFILE_ENTRY =         "\"%{statenum}\": {
          \"GUID\": \"4b8ee6\",
          \"Name\": \"Custom_Token\",
          \"Transform\": {
            \"posX\": 0,
            \"posY\": 0,
            \"posZ\": 0,
            \"rotX\": 0,
            \"rotY\": 180,
            \"rotZ\": %{rotation},
            \"scaleX\": 0.98,
            \"scaleY\": 0.2,
            \"scaleZ\": 0.98
          },
          \"Nickname\": \"%{name}\",
          \"Description\": \"\",
          \"GMNotes\": \"\",
          \"ColorDiffuse\": {
            \"r\": 1.0,
            \"g\": 1.0,
            \"b\": 1.0
          },
          \"CustomImage\": {
            \"ImageURL\": \"%{url}\",
            \"ImageSecondaryURL\": \"\",
            \"ImageScalar\": 1.0,
            \"WidthScale\": 0.0,
            \"CustomToken\": {
              \"Thickness\": 0.2,
              \"MergeDistancePixels\": 15.0,
              \"StandUp\": false,
              \"Stackable\": false
            }
          },
          \"LuaScript\": \"\",
          \"LuaScriptState\": \"\",
          \"XmlUI\": \"\"
        },"
STATEDFILE_CLOSE = "}}]}"
