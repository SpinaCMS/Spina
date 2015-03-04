class CreateSpinaLines < ActiveRecord::Migration
  def change
    create_table :spina_lines do |t|
      t.string :content

      t.timestamps
    end
  end
end
