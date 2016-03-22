class CreateTranslationTables < ActiveRecord::Migration
  def up
    Spina::Page.create_translation_table! title: :string, menu_title: :string, description: :string, seo_title: :string, materialized_path: :string
  end
end
