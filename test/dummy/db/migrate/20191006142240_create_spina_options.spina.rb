# This migration comes from spina (originally 6)
class CreateSpinaOptions < ActiveRecord::Migration[5.0]
  def change
    create_table :spina_options do |t|
      t.string :value
      t.timestamps
    end
  end
end
