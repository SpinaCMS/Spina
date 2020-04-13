module Spina
  module Parts
    class AttachmentCollection < Base
      attr_json :attachment_tokens, :string, default: ""

      def attachment_ids
        attachment_tokens.split(",").map(&:to_i)
      end

      def attachments
        @attachments ||= Spina::Attachment.where(id: attachment_ids).sort_by do |attachment|
          attachment_ids.index(attachment.id)
        end
      end

    end
  end
end