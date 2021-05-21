module Spina
  class Attachment < ApplicationRecord
    has_one_attached :file

    attr_accessor :_destroy

    scope :sorted, -> { order('created_at DESC') }

    def name
      file.filename.to_s
    end

    def content
      file if file.attached?
    end

    alias_method :old_update, :update
    def update(attributes)
      if attributes["_destroy"] == "1" && attributes["file"].blank?
        self.page_part.destroy
      else
        old_update(attributes)
      end
    end

  end
end
