module Spina
  module Parts
    class ImageVariant
      attr_reader :blob
      
      def initialize(image, options)
        @blob = image
        @options = options
      end
      
      def variation
        OpenStruct.new({
          key: ActiveStorage::Variation.encode(@options)
        })
      end 

    end
  end
end
