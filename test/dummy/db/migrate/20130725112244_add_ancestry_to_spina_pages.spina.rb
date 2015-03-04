# This migration comes from spina (originally 20130725111749)
class AddAncestryToSpinaPages < ActiveRecord::Migration
  def change
    add_column :spina_pages, :ancestry, :string
    add_column :spina_pages, :position, :integer
    remove_column :spina_pages, :parent_id, :integer
    remove_column :spina_pages, :depth, :integer
    remove_column :spina_pages, :rgt, :integer
    remove_column :spina_pages, :lft, :integer
  end
end
