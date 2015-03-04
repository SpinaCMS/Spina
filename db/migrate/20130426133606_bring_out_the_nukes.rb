class BringOutTheNukes < ActiveRecord::Migration
  def change
    remove_column :spina_pages, :parent_id
    add_column :spina_pages, :parent_id, :integer
  end
end
