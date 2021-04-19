module Card
  module Models
    class StoredCard
      attr_reader :image_url, :spec

      def initialize(spec, image_url)
        @image_url = image_url
        @spec = spec
      end
    end
  end
end
