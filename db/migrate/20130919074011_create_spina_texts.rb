class CreateSpinaTexts < ActiveRecord::Migration
  def change
    create_table :spina_texts do |t|
      t.string :content

      t.timestamps
    end
  end
end
