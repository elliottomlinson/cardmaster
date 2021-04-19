module Card
  module Models
    class StoredCard
      attr_reader :image_url, :spec, :back_url

      def initialize(spec, image_url, back_url)
        @image_url = image_url
        @spec = spec
        @back_url = back_url
      end
    end
  end
end
