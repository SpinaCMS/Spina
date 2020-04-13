module Spina
  module Parts
    class Attachment < Base
      attr_json :attachment_id, :integer, default: nil

      def attachment
        @attachment ||= Spina::Attachment.find_by(id: attachment_id)
      end
    end
  end
end
