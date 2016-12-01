# This migration comes from spina (originally 2)
class CreateSpinaTranslationTables < ActiveRecord::Migration
  def up
    Spina::Page.create_translation_table!({
      title: :string,
      menu_title: :string,
      description: :string,
      seo_title: :string,
      materialized_path: :string
    }, {
      migrate_data: true,
      remove_source_columns: true
    })
    Spina::Text.create_translation_table!({
      content: :text
    }, {
      migrate_data: true,
      remove_source_columns: true
    })
    Spina::Line.create_translation_table!({
      content: :string
    }, {
      migrate_data: true,
      remove_source_columns: true
    })
  end

  def down
    Spina::Page.drop_translation_table! migrate_data: true
    Spina::Text.drop_translation_table! migrate_data: true
    Spina::Line.drop_translation_table! migrate_data: true
  end
end
