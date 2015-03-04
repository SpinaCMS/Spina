class CreateLayoutParts < ActiveRecord::Migration
  def change
    create_table :spina_layout_parts do |t|
      t.string   :title
      t.string   :name
      t.integer  :layout_partable_id
      t.string   :layout_partable_type

      t.timestamps
    end
  end
end
