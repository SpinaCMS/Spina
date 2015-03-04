class SwitchToNestedSetsInsteadOfPositionPages < ActiveRecord::Migration
  
  def change
    remove_column :spina_pages, :position
    add_column :spina_pages, :lft, :integer
    add_column :spina_pages, :rgt, :integer
    add_column :spina_pages, :depth, :integer
  end

end
