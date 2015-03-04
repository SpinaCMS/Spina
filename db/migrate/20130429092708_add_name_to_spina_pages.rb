class AddNameToSpinaPages < ActiveRecord::Migration
  def change
    add_column :spina_pages, :name, :string
  end
end
