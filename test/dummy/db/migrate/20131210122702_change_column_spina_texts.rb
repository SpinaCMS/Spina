class ChangeColumnSpinaTexts < ActiveRecord::Migration
  def change
    change_column :spina_texts, :content, :text
  end
end
