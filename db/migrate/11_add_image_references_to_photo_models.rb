class AddImageReferencesToPhotoModels < ActiveRecord::Migration[5.2]
  def change
    add_column :spina_photos, :image_id, :integer,
               foreign_key: { to_table: :spina_images }
  end
end
