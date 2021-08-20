module Card
  module Models
    class StoredCard
      attr_reader :image_url, :spec, :back_url

      def initialize(spec, image_url, back_url)
        @image_url = image_url
        @spec = spec
        @back_url = back_url
      end

      def to_h
        {
          "image_url" => image_url,
          "spec" => spec.to_h,
          "back_url" => back_url
        }
      end

      def self.from_h(hash)
        StoredCard.new(
          CardSpecification.from_h(hash["spec"]),
          hash["image_url"],
          hash["back_url"]
        )
      end
    end
  end
end
