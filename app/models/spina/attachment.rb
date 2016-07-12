module Spina
  class Attachment < ApplicationRecord

    has_one :page_part, as: :page_partable
    has_and_belongs_to_many :attachment_collections, join_table: 'spina_attachment_collections_attachments'

    attr_accessor :_destroy

    scope :sorted, -> { order('created_at DESC') }
    scope :file_attached, -> { where('file IS NOT NULL') }

    mount_uploader :file, FileUploader

    def name
      file.file.try(:filename)
    end

    alias_method :old_update_attributes, :update_attributes
    def update_attributes(attributes)
      if attributes["_destroy"] == "1" && attributes["file"].blank?
        self.page_part.destroy
      else
        old_update_attributes(attributes)
      end
    end

    def self.order_by_ids(ids)
      sql = sanitize_sql_for_assignment({id: ids})
      order("CASE WHEN #{sql} THEN 0 ELSE 1 END")
    end

  end
end
