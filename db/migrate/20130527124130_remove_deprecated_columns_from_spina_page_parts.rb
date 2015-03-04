class RemoveDeprecatedColumnsFromSpinaPageParts < ActiveRecord::Migration
  def up
    remove_column :spina_page_parts, :file
    remove_column :spina_page_parts, :position
  end

  def down
    add_column :spina_page_parts, :file, :string
    add_column :spina_page_parts, :position, :integer
  end
end
