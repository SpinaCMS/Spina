module Spina
  module Parts
    class Image < Base
      attr_json :image_id, :integer, default: nil
      attr_json :signed_blob_id, :string, default: nil
      attr_json :alt, :string, default: ""

      def content
        self
      end

      def image
        Spina::Image.find_by(id: image_id)
      end
    end
  end
end
