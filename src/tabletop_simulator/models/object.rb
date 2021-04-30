require "json"
require "json-schema"

module TabletopSimulator
  module Models
    class Object
      def initialize(default_state)
        @hash = default
        @hash["ObjectStates"] = [default_state.to_h]
      end

      def default
        {
          "SaveName" => "",
          "Date" => "",
          "VersionNumber" => "",
          "GameMode" => "",
          "GameType" => "",
          "GameComplexity" => "",
          "Tags" => [],
          "Gravity" => 0.5,
          "PlayArea" => 0.5,
          "Table" => "",
          "Sky" => "",
          "Note" => "",
          "TabStates" => {},
          "LuaScript" => "",
          "LuaScriptState" => "",
          "XmlUI" => ""
        }
      end

      def to_h
        @hash
      end
    end

    class ObjectState
      ARBITRARY_CARD_ID = 100

      def initialize(overrides)
        @hash = default.merge(overrides)
      end

      def self.card(nickname:, front_url:, back_url:, card_id: nil)
        self.new(
          "Nickname" => nickname,
          "Name" => "CardCustom",
          "CardID" => card_id || ARBITRARY_CARD_ID,
          "CustomDeck" => CustomDeck.new([
            CustomDeckEntry.new(front_url, back_url)
          ]).to_h
        )
      end

      def self.deck(nickname:, cards:)
        self.new(
          "Nickname" => nickname,
          "Name" => "Deck",
          "DeckIDs" => cards.map { |card| card.to_h["CardID"] },
          "CustomDeck" => CustomDeck.new(
            cards.map do |card|
              deck_entry_info = card.to_h["CustomDeck"]["1"]

              CustomDeckEntry.new(
                deck_entry_info["FaceURL"],
                deck_entry_info["BackURL"]
              )
            end
          ).to_h,
          "ContainedObjects" => cards.map(&:to_h)
        )
      end

      def default
        {
          "GUID" => "0e0683",
          "Transform" => {
            "posX" => 0.0,
            "posY" => 0.0,
            "posZ" => 0.0,
            "rotX" => 0.0,
            "rotY" => 0.0,
            "rotZ" => 0.0,
            "scaleX" => 1.0,
            "scaleY" => 1.0,
            "scaleZ" => 1.0
          },
          "Nickname" => "",
          "Description" => "",
          "GMNotes" => "",
          "ColorDiffuse" => {
            "r" => 0.713235259,
            "g" => 0.713235259,
            "b" => 0.713235259
          },
          "LayoutGroupSortIndex" => 0,
          "Value" => 0,
          "Locked" => false,
          "Grid" => true,
          "Snap" => true,
          "IgnoreFoW" => false,
          "MeasureMovement" => false,
          "DragSelectable" => true,
          "Autoraise" => true,
          "Sticky" => true,
          "Tooltip" => true,
          "GridProjection" => false,
          "HideWhenFaceDown" => false,
          "Hands" => true,
          "SidewaysCard" => false,
          "LuaScript" => "",
          "LuaScriptState" => "",
          "XmlUI" => ""
        }
      end

      def to_h
        @hash
      end
    end

    class CustomDeck
      def initialize(deck_entries)
        @hash = {}
        deck_entries.each.with_index(1) do |deck_entry, index|
          @hash[index.to_s] = deck_entry.to_h
        end
      end

      def to_h
        @hash
      end
    end

    class CustomDeckEntry
      def initialize(face_url, back_url)
        @hash = {
          "FaceURL" => face_url,
          "BackURL" => back_url,
          "NumWidth" => 1,
          "NumHeight" => 1,
          "BackIsHidden" => true,
          "UniqueBack" => false,
          "Type" => 0
        }
      end

      def to_h
        @hash
      end
    end
  end
end
