# This migration comes from spina (originally 20130503110240)
class FixNamespaces < ActiveRecord::Migration
  def change
    drop_table :spina_spina_files

    create_table :spina_files do |t|
      t.string :file
      t.integer :page_part_id
      
      t.timestamps
    end
  end
end
