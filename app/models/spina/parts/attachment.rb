module Spina
  module Parts
    class Attachment < Base
      attr_json :attachment_id, :integer, default: nil
      attr_json :signed_blob_id, :string, default: nil

      def content
        self
      end
    end
  end
end
