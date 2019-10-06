# This migration comes from spina (originally 10)
class CreateSpinaImageCollections < ActiveRecord::Migration[5.2]
  def change
    create_table :spina_image_collections do |t|
      t.timestamps
    end

    create_table "spina_image_collections_images", id: :serial, force: :cascade do |t|
      t.integer "image_collection_id"
      t.integer "image_id"
      t.integer "position"
    end

    add_index :spina_image_collections_images, :image_collection_id
    add_index :spina_image_collections_images, :image_id
  end
end
