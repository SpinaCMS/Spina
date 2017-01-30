module Spina
  class PhotoCollection < ApplicationRecord

    has_one :page_part, as: :page_partable
    has_many :photo_collections_photos, autosave: true
    has_many :photos, through: :photo_collections_photos
    has_many :structure_parts, as: :structure_partable

    attr_reader :photo_tokens, :photo_positions
    accepts_nested_attributes_for :photos, allow_destroy: true

    def content
      self
    end

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

    alias_method :old_update_attributes, :update_attributes
    def update_attributes(attributes)
      self.photos.clear if attributes.reject{|key,value| key == "id" }.blank?
      old_update_attributes(attributes)
    end

  end
end
