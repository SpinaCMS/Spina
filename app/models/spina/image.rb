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
      return "" unless file.attached?
      return file if file.content_type.include?('svg')
      return file unless file.variable?

      file.variant(options)
    end

    def content
      self
    end

    def thumbnail(size = '100x100', modifier = '^')
      variant(
        combine_options: {
          gravity: 'center',
          thumbnail: "#{size}#{modifier}",
          extent: size
        }
      )
    end
  end
end
