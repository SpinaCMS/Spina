class CreateStructures < ActiveRecord::Migration
  def change
    create_table :spina_structures do |t|
      t.timestamps
    end

    create_table :spina_structure_items do |t|
      t.integer :structure_id
      t.integer :position
      t.timestamps
    end

    add_index :spina_structure_items, :structure_id

    create_table :spina_structure_parts do |t|
      t.integer :structure_item_id
      t.integer :structure_partable_id
      t.string :structure_partable_type
      t.string :name
      t.string :title
      t.timestamps
    end

    add_index :spina_structure_parts, :structure_item_id
    add_index :spina_structure_parts, :structure_partable_id
  end
end
