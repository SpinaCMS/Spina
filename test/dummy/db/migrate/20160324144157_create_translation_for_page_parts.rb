class CreateTranslationForPageParts < ActiveRecord::Migration
  def up
    Spina::Line.create_translation_table! content: :string
    Spina::Text.create_translation_table! content: :text
  end

  def down
    Spina::Line.drop_translation_table!
    Spina::Text.drop_translation_table!
  end
end
