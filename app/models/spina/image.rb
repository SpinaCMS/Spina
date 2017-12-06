module Spina
  class Image < ApplicationRecord
    self.table_name = 'spina_images'

    belongs_to :media_folder, optional: true

    has_one_attached :file

    has_many :page_parts, as: :page_partable
    has_many :structure_parts, as: :structure_partable

    scope :sorted, -> { order('created_at DESC') }

    def name
      "filename"
    end

    def content
      self
    end
  end
end
