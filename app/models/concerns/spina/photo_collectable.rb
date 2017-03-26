require 'active_support/concern'

module Spina
  module PhotoCollectable
    extend ActiveSupport::Concern

    included do
      attr_reader :photo_tokens, :photo_positions
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

  end
end