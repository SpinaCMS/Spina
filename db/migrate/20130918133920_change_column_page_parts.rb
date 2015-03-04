class ChangeColumnPageParts < ActiveRecord::Migration
  def change
    rename_column :spina_page_parts, :name, :title
    rename_column :spina_page_parts, :tag, :name
  end
end
