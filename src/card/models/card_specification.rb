module Card
  module Models
    class CardSpecification
      VALID_TIERS = [:grey, :blue, :green, :red, :gold].freeze

      attr_accessor :title, :rules, :upgrade, :tier, :flavour, :art_path

      def initialize(title, rules, upgrade, tier, flavour, art_path, tags=[])
        @title = title
        @rules = rules
        @upgrade = upgrade
        @tier = validate_tier!(tier)
        @flavour = flavour
        @art_path = art_path
        @tags = tags
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
  end
end
