require 'active_support/concern'

module Spina
  module ImageCollectable
    extend ActiveSupport::Concern

    included do
      attr_reader :image_tokens, :image_positions
    end

    def image_tokens=(ids)
      self.image_ids = ids.split(",")
    end

    def image_positions=(positions)
      positions = positions.split(",")
      self.image_collections_images.each do |image|
        image.position = positions.index(image.image.try(:id).try(:to_s))
      end
    end

  end
end