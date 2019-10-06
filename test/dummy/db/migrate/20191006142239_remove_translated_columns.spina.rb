# This migration comes from spina (originally 5)
class RemoveTranslatedColumns < ActiveRecord::Migration[5.0]
  def change
    remove_column :spina_lines, :content
    remove_column :spina_texts, :content
    remove_column :spina_pages, :title
    remove_column :spina_pages, :menu_title
    remove_column :spina_pages, :description
    remove_column :spina_pages, :seo_title
    remove_column :spina_pages, :materialized_path
  end
end
