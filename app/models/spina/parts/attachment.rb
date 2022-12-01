module Spina
  module Parts
    class Attachment < Base
      attr_json :attachment_id, :integer, default: nil
      attr_json :signed_blob_id, :string, default: nil
      attr_json :filename, :string, default: ""

      def content
        self
      end

      def present?
        signed_blob_id.present?
      end

      def signed_id(expires_in: nil)
        signed_blob_id
      end
    end
  end
end
