class CreateSpinaTranslationTables < ActiveRecord::Migration[4.2]
  def up
    Spina::Page.create_translation_table! title: :string, menu_title: :string, description: :string, seo_title: :string, materialized_path: :string
    Spina::Text.create_translation_table! content: :text
    Spina::Line.create_translation_table! content: :string
  end

  def down
    Spina::Page.drop_translation_table!
    Spina::Text.drop_translation_table!
    Spina::Line.drop_translation_table!
  end
end
