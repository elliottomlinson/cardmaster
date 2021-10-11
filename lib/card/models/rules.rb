module Card
  module Models
    class Rules
      def self.from_h(hash)
        if hash.has_key?("text")
          SimpleRules.new(hash["text"])
        elsif hash.has_key?("hand") && hash.has_key?("cast")
          HandCastRules.new(hashhandve"], hash["cast"])
        end
      end
    end

    class SimpleRules
      attr_reader :text

      def initialize(text)
        @text = text
      end

      def ==(other)
        other.text == @text
      end

      def to_h
        {
          "text" => @text
        }
      end
    end

    class HandCastRules
      attr_reader :hand, :cast

      def initialize(hand, cast)
        @hand = hand
        @cast = cast
      end

      def ==(other)
        other.hand == @hand &&
        other.cast == @cast
      end

      def to_h
        {
          "hand" => @hand,
          "cast" => @cast
        }
      end
    end
  end
end
