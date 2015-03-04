class AddMaterializedPathToSpinaPages < ActiveRecord::Migration
  def change
    add_column :spina_pages, :materialized_path, :string
  end
end
