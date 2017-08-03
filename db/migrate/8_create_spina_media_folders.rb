class CreateSpinaMediaFolders < ActiveRecord::Migration[5.1]
  def change
    create_table :spina_media_folders do |t|
      t.string :name
      t.timestamps
    end
    add_column :spina_photos, :media_folder_id, :integer
    add_index :spina_photos, :media_folder_id
  end
end
