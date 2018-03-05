module Spina
  class PhotoCollectionsPhoto < ApplicationRecord
    belongs_to :photo, optional: true
    belongs_to :photo_collection, optional: true
  end
end
