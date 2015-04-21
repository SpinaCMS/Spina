module Spina
  class Photo < ActiveRecord::Base
    mount_uploader :file, PhotoUploader

    has_many :page_parts, as: :page_partable
    has_many :structure_parts, as: :structure_partable
    has_many :photo_collections_photos
    has_many :photo_collections, through: :photo_collections_photos

    scope :sorted, -> { order('created_at DESC') }
    scope :sorted_by_photo_collection, -> { order('position') }

    validates_presence_of :file

    def name
      file.file.filename
    end

    def content
      self
    end
    
  end
end
