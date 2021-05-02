module Card
  module Models
    class CardSpecification
      VALID_TIERS = [:grey, :blue, :green, :red, :gold].freeze

      attr_accessor :title, :rules, :upgrade, :tier, :flavour, :art_path, :tags

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

      def ==(other)
        title == other.title &&
          rules == other.rules &&
          upgrade == other.upgrade &&
          tier == other.tier &&
          flavour == other.flavour &&
          art_path == other.art_path &&
          tags == other.tags
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
