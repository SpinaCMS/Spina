class CreateSpinaResources < ActiveRecord::Migration[5.1]
  def change
    create_table :spina_resources do |t|
      t.string :name
      t.string :label
      t.timestamps
    end
    add_column :spina_pages, :resource_id, :integer, null: true
    add_index :spina_pages, :resource_id
  end
end
