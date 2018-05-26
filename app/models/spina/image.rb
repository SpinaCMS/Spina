module Spina
  class Image < ApplicationRecord
    belongs_to :media_folder, optional: true

    has_one_attached :file

    has_many :page_parts, as: :page_partable
    has_many :structure_parts, as: :structure_partable

    scope :sorted, -> { order('created_at DESC') }
    scope :sorted_by_image_collection, -> { order('position') }

    def name
      file.try(:filename).to_s
    end

    def variant(options)
      file.attached? ? file.variant(options) : ""
    end

    def content
      self
    end
 
  end
end
