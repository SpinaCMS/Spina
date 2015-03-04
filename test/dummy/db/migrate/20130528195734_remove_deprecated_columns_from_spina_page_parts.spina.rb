# This migration comes from spina (originally 20130527124130)
class RemoveDeprecatedColumnsFromSpinaPageParts < ActiveRecord::Migration
  def up
    remove_column :spina_page_parts, :file_id
    remove_column :spina_page_parts, :file
    remove_column :spina_page_parts, :position
  end

  def down
    add_column :spina_page_parts, :file_id, :integer
    add_column :spina_page_parts, :file, :string
    add_column :spina_page_parts, :position, :integer
  end
end
