module Spina
  module Parts
    class Image < Base
      attr_json :image_id, :integer, default: nil
      attr_json :signed_blob_id, :string, default: nil
      attr_json :alt, :string, default: ""
      attr_json :filename, :string, default: ""

      def to_s
        alt.presence || filename.presence || Spina::Image.model_name.human
      end

      def content
        self
      end

      def svg?
        filename =~ /\.svg\z/
      end

      def spina_image
        Spina::Image.find_by(id: image_id)
      end

      def present?
        signed_blob_id.present?
      end
      
      def signed_id
        signed_blob_id
      end
      
      def variant(options)
        Spina::Parts::ImageVariant.new(self, options)
      end
      
    end
  end
end
