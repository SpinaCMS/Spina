class RemoveTranslatedColumns < ActiveRecord::Migration[5.0]
  def change
    remove_column :spina_lines, :content, :string
    remove_column :spina_texts, :content, :text
    remove_column :spina_pages, :title, :string
    remove_column :spina_pages, :menu_title, :string
    remove_column :spina_pages, :description, :text
    remove_column :spina_pages, :seo_title, :string
    remove_column :spina_pages, :materialized_path, :string
  end
end
