module Card
  module Models
    class SimpleRules
      attr_reader :text

      def initialize(text)
        @text = text
      end

      def ==(other)
        other.text == @text
      end
    end

    class PassiveActiveRules
      attr_reader :passive, :cast

      def initialize(passive, cast)
        @passive = passive
        @cast = cast
      end

      def ==(other)
        other.passive == @passive &&
        other.cast == @cast
      end
    end
  end
end
