class AddParentIdToSpinaPages < ActiveRecord::Migration
  def change
    add_column :spina_pages, :parent_id, :integer
  end
end
