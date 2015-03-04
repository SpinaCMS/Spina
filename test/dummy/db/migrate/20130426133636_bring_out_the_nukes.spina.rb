# This migration comes from spina (originally 20130426133606)
class BringOutTheNukes < ActiveRecord::Migration
  def change
    remove_column :spina_pages, :parent_id
    add_column :spina_pages, :parent_id, :integer
  end
end
