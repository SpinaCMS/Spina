class AddFileToSpinaPageParts < ActiveRecord::Migration
  def change
    add_column :spina_page_parts, :file_id, :integer
  end
end
