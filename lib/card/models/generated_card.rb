module Card
  module Models
    class GeneratedCard
      attr_reader :image_path, :spec, :back_path

      def initialize(image_path, spec, back_path)
        @image_path = image_path
        @spec = spec
        @back_path = back_path
      end
    end
  end
end
