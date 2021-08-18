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
      attr_reader :passive, :active

      def initialize(passive, active)
        @passive = passive
        @active = active
      end

      def ==(other)
        other.passive == @passive &&
        other.active == @active
      end
    end
  end
end
