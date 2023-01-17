module Spina
  class Attachment < ApplicationRecord
    has_one_attached :file

    attr_accessor :_destroy

    scope :sorted, -> { order("created_at DESC") }
    scope :with_filename, ->(query) do
      joins(:file_blob).where(
        "active_storage_blobs.filename ILIKE ?",
        "%" + Attachment.sanitize_sql_like(query) + "%"
      )
    end

    def name
      file.filename.to_s
    end

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
