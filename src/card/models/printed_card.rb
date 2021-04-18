module Card
  module Models
    class PrintedCard
      attr_reader :image_path, :spec
      attr_accessor :image_url

      def initialize(image_path, spec, image_url=nil)
        @image_path = image_path
        @image_url = image_url
        @spec = spec
      end
    end
  end
end
