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
  \"CardID\": %{cardnum},
  \"SidewaysCard\": false,
  \"CustomDeck\": {
    \"40\": {
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
