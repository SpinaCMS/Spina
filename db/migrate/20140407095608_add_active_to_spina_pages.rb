class AddActiveToSpinaPages < ActiveRecord::Migration
  def change
    add_column :spina_pages, :active, :boolean, default: true
  end
end
