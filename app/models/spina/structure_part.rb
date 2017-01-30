module Spina
  class StructurePart < ApplicationRecord
    include Part

    belongs_to :structure_item, optional: true
    belongs_to :structure_partable, polymorphic: true, optional: true

    accepts_nested_attributes_for :structure_partable, allow_destroy: true

    validates :structure_partable_type, presence: true
    validates :name, uniqueness: {scope: :structure_item_id}

    alias_attribute :partable, :structure_partable
    alias_attribute :partable_type, :structure_partable_type
    alias_method :structure_partable_attributes=, :partable_attributes=

    attr_reader :photo_tokens, :photo_positions
    def photo_tokens=(ids)
      self.photo_ids = ids.split(",")
    end

    def photo_positions=(positions)
      positions = positions.split(",")
      self.photo_collections_photos.each do |photo|
        photo.position = positions.index(photo.photo.try(:id).try(:to_s))
      end
      logger.info self.photo_collections_photos.inspect
    end
  end
end
