module Spina
  module Parts
    class ImageVariant
      ImageVariation = Struct.new(:key)

      attr_reader :blob

      def initialize(image, options)
        @blob = image
        @options = options
      end

      def variation
        ImageVariation.new(ActiveStorage::Variation.encode(@options))
      end
    end
  end
end
