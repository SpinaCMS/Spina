require 'active_support/concern'

module Spina
  module ImageCollectable
    extend ActiveSupport::Concern

    included do
      attr_reader :image_tokens
    end

    def image_tokens=(ids)
      self.image_ids = ids.split(",")
      self.image_collections_images.each do |image|
        image.position = ids.index(image.image.try(:id).try(:to_s))
      end
    end

  end
end