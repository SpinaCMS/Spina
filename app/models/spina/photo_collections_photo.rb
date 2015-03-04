module Spina
  class PhotoCollectionsPhoto < ActiveRecord::Base
    belongs_to :photo
    belongs_to :photo_collection
  end
end
