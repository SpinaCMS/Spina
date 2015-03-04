# This migration comes from spina (originally 20130426122705)
class AddParentIdToSpinaPages < ActiveRecord::Migration
  def change
    add_column :spina_pages, :parent_id, :integer
  end
end
