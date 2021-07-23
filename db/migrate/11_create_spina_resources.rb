class CreateSpinaResources < ActiveRecord::Migration[5.1]
  def change
    create_table :spina_resources do |t|
      t.string :name, null: false, unique: true
      t.string :label
      t.string :view_template
      t.string :order_by
      t.timestamps
    end
    add_column :spina_pages, :resource_id, :integer, null: true
    add_index :spina_pages, :resource_id
  end
end
