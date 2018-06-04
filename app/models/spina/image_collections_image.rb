module Spina
  class ImageCollectionsImage < ApplicationRecord
    belongs_to :image
    belongs_to :image_collection
  end
end
