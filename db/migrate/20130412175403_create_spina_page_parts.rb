class CreateSpinaPageParts < ActiveRecord::Migration
  def change
    create_table :spina_page_parts do |t|
      t.string :name
      t.integer :position, default: 0
      t.string :content_type
      t.string :tag

      t.timestamps
    end
  end
end
