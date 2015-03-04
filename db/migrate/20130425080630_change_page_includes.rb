class ChangePageIncludes < ActiveRecord::Migration
  def change
    drop_table :spina_page_includes
    add_column :spina_page_parts, :page_id, :integer
    add_column :spina_page_parts, :photo_id, :integer
    add_column :spina_page_parts, :content, :text
  end
end
