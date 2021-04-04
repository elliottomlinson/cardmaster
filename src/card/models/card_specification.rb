module Card
  module Models
    class CardSpecification
      VALID_TIERS = [:grey, :blue, :green, :red, :gold].freeze

      attr_accessor :title, :rules, :upgrade, :tier, :flavour, :art_path

      def initialize(title, rules, upgrade, tier, flavour, art_path)
        @title = title
        @rules = rules
        @upgrade = upgrade
        @tier = validate_tier!(tier)
        @flavour = flavour
        @art_path = art_path
      end

      def typeline
        "Upgrade - #{@upgrade || "None"}"
      end

      private

      def to_s
        inspect
      end

      def validate_tier!(tier)
        raise "Received invalid tier #{tier}" unless VALID_TIERS.include?(tier)

        tier
      end
    end

    MOCK_CARD_SPECIFICATION = CardSpecification.new(
      "Foo",
      "Deal X damage to every non-player character you've ever known, where X is the number of complaints you can list in 30 seconds",
      "Bar",
      :blue,
      "\"The world is irredeemable. I have yet to meet a soul worth saving.\" -Fester the Limp",
      "assets/core/card/illustration/Inner\ Sun.png"
    )
  end
end
