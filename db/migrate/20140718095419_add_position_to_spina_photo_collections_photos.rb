class AddPositionToSpinaPhotoCollectionsPhotos < ActiveRecord::Migration
  def change
    add_column :spina_photo_collections_photos, :position, :integer
  end
end
