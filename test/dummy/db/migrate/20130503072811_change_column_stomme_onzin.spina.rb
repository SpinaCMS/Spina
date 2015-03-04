# This migration comes from spina (originally 20130429124414)
class ChangeColumnStommeOnzin < ActiveRecord::Migration
  def change
    remove_column :spina_pages, :position
    add_column :spina_pages, :position, :integer
  end
end
