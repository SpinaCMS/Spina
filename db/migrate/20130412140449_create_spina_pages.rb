class CreateSpinaPages < ActiveRecord::Migration
  def change
    create_table :spina_pages do |t|
      t.string :title
      t.string :menu_title
      t.string :description
      t.boolean :show_in_menu
      t.string :position
      t.string :slug
      t.integer :deletable

      t.timestamps
    end
  end
end
