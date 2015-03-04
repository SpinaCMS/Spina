class CreateSpinaPageIncludes < ActiveRecord::Migration
  def change
    create_table :spina_page_includes do |t|
      t.text :content
      t.integer :page_id
      t.integer :page_part_id
      t.integer :photo_id

      t.timestamps
    end
  end
end
