class RemoveColumnFromSpinaPageParts < ActiveRecord::Migration
  def change
    remove_column :spina_page_parts, :content
  end
end
