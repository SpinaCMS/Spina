module Spina
  class Attachment < ApplicationRecord
    include Attachable
    
    attr_accessor :_destroy

    scope :sorted, -> { order("created_at DESC") }

    def content
      file if file.attached?
    end

    def present?
      signed_blob_id.present?
    end

    alias_method :old_update, :update
    def update(attributes)
      if attributes["_destroy"] == "1" && attributes["file"].blank?
        page_part.destroy
      else
        old_update(attributes)
      end
    end
  end
end
