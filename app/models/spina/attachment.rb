module Spina
  class Attachment < ApplicationRecord
    has_one_attached :file

    has_one :page_part, as: :page_partable
    has_many :structure_parts, as: :structure_partable
    has_and_belongs_to_many :attachment_collections, join_table: 'spina_attachment_collections_attachments'

    attr_accessor :_destroy

    scope :sorted, -> { order('file ASC') }

    def name
      file.filename.to_s
    end

    def content
      file if file.attached?
    end

    alias_method :old_update_attributes, :update_attributes
    def update_attributes(attributes)
      if attributes["_destroy"] == "1" && attributes["file"].blank?
        self.page_part.destroy
      else
        old_update_attributes(attributes)
      end
    end

  end
end
