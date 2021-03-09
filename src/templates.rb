require_relative "./config.rb"

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
