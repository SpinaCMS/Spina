module Spina
  module Parts
    class Image < Base
      attr_json :image_id, :integer, default: nil
      attr_json :signed_blob_id, :string, default: nil
      attr_json :alt, :string, default: ""

      def content
        image
      end

      def image
        @image ||= Spina::Image.find_by(id: image_id)
      end

      def attachment
        ActiveStorage::Attachment.where(record_id: image_id, record_type: "Spina::Image", name: "file").first
      end
    end
  end
end
