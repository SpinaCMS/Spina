# This migration comes from spina (originally 9)
class CreateSpinaImages < ActiveRecord::Migration[5.2]
  def change
    create_table :spina_images do |t|
      t.integer :media_folder_id

      t.timestamps
    end
    add_index :spina_images, :media_folder_id
  end
end
