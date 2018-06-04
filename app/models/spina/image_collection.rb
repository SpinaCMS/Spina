module Spina
  class ImageCollection < ApplicationRecord
    include ImageCollectable

    has_one :page_part, as: :page_partable
    has_many :image_collections_images, autosave: true
    has_many :images, through: :image_collections_images
    has_many :structure_parts, as: :structure_partable

    accepts_nested_attributes_for :images, allow_destroy: true

    def content
      self
    end

    alias_method :old_update_attributes, :update_attributes
    def update_attributes(attributes)
      self.images.clear if attributes.reject{|key,value| key == "id" }.blank?
      old_update_attributes(attributes)
    end

  end
end
