class ChangeColumnsSpinaFiles < ActiveRecord::Migration
  def change
    remove_column :spina_page_parts, :file_id
    add_column :spina_page_parts, :file, :string
  end
end
