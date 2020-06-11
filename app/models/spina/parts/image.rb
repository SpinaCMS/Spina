module Spina
  module Parts
    class Image < Base
      attr_json :image_id, :integer, default: nil
      attr_json :signed_blob_id, :string, default: nil
      attr_json :alt, :string, default: ""
      attr_json :filename, :string, default: ""

      def content
        self
      end

      def svg?
        filename =~ /\.svg\z/
      end

      def spina_image
        Spina::Image.find(image_id)
      end

      def present?
        signed_blob_id.present?
      end
    end
  end
end
