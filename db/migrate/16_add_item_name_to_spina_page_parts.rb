class AddItemNameToSpinaPageParts  < ActiveRecord::Migration[5.2]
  def change
    add_column :spina_page_parts, :item_name, :string
  end
end
