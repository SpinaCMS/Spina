class CreateSpinaLinks < ActiveRecord::Migration[5.0]
  def change
    create_table :spina_links do |t|
      t.integer :page_id, null: false
      t.string :title
      t.timestamps
    end
  end
end
