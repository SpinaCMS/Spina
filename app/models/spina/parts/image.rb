module Spina
  module Parts
    class Image < Base
      attr_json :image_id, :integer, default: nil
      attr_json :signed_blob_id, :string, default: nil
      attr_json :alt, :string, default: ""
      attr_json :filename, :string, default: "image"

      def content
        self
      end
    end
  end
end
