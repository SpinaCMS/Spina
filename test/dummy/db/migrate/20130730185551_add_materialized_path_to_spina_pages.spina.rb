# This migration comes from spina (originally 20130730185527)
class AddMaterializedPathToSpinaPages < ActiveRecord::Migration
  def change
    add_column :spina_pages, :materialized_path, :string
  end
end
