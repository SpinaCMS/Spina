# This migration comes from spina (originally 8)
class CreateSpinaMediaFolders < ActiveRecord::Migration[5.1]
  def change
    create_table :spina_media_folders do |t|
      t.string :name
      t.timestamps
    end
  end
end
