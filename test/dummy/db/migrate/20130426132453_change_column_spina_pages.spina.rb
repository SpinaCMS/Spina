# This migration comes from spina (originally 20130426132336)
class ChangeColumnSpinaPages < ActiveRecord::Migration
  def change
    change_column :spina_pages, :parent_id, :integer, default: 0, null: false
  end
end
