class ChangeDefaultSpinaResourcesSlug < ActiveRecord::Migration[7.0]
  def up
    change_column :spina_resources, :slug, :json, default: {}
  end

  def down
    change_column :spina_resources, :slug, :json, default: nil
  end
end
