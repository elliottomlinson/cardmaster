module Card
  module Models
    class Rules
      def self.from_h(hash)
        if hash.has_key?("text")
          SimpleRules.new(hash["text"])
        elsif hash.has_key?("passive") && hash.has_key?("active")
          PassiveActiveRules.new(hash["passive"], hash["active"])
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

      def to_h
        {
          "passive" => @passive,
          "active" => @active
        }
      end
    end
  end
end
