module Spina
  class PhotoCollectionsPhoto < ApplicationRecord
    belongs_to :photo
    belongs_to :photo_collection
  end
end
