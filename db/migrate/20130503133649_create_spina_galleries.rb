class CreateSpinaGalleries < ActiveRecord::Migration
  def change
    create_table :spina_galleries do |t|
      t.integer :photo_id
      t.integer :page_part_id

      t.timestamps
    end
  end
end
