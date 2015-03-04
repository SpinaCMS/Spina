# This migration comes from spina (originally 20130429092708)
class AddNameToSpinaPages < ActiveRecord::Migration
  def change
    add_column :spina_pages, :name, :string
  end
end
