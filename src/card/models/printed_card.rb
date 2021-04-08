module Card
  module Models
    class PrintedCard
      attr_reader :image_path, :spec

      def initialize(image_path, spec)
        @image_path = image_path
        @spec = spec
      end
    end
  end
end
