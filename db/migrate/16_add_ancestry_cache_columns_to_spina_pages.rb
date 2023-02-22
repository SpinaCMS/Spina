class AddAncestryCacheColumnsToSpinaPages < ActiveRecord::Migration[6.0]
  def change
    add_column :spina_pages, :ancestry_depth, :integer, default: 0
    add_column :spina_pages, :ancestry_children_count, :integer
  end
end
