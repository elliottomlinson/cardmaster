require_relative "./rules.rb"

module Card
  module Models
    class CardSpecification
      TIER_HIERARCHY = [:grey, :blue, :green, :red, :gold].freeze

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
        @upgrade == '' ? "Unique" : "Upgrade - #{@upgrade}"
      end

      def next_tier
        return nil if TIER_HIERARCHY[-1] == tier

        TIER_HIERARCHY[TIER_HIERARCHY.index(tier) + 1]
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

      def to_h
        {
          "title" => @title,
          "rules" => @rules.to_h,
          "upgrade" => @upgrade,
          "tier" => @tier.to_s,
          "flavour" => @flavour,
          "art_path" => @art_path,
          "tags" => @tags
        }
      end

      def self.from_h(hash)
        CardSpecification.new(
          hash["title"],
          Rules.from_h(hash["rules"]),
          hash["upgrade"],
          hash["tier"].to_sym,
          hash["flavour"],
          hash["art_path"],
          hash["tags"]
        )
      end

      private

      def to_s
        inspect
      end

      def validate_tier!(tier)
        raise "Received invalid tier #{tier}" unless TIER_HIERARCHY.include?(tier)

        tier
      end
    end
  end
end
