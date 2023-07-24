class AddCustomUrlsToSpinaNavigationItems < ActiveRecord::Migration[7.0]
  def change
    add_column :spina_navigation_items, :url, :string
    add_column :spina_navigation_items, :url_label, :string

    reversible do |dir|
      dir.up do
        change_column_null :spina_navigation_items, :page_id, true
      end

      dir.down do
        Spina::NavigationItem.where(page_id: nil).delete_all
        change_column_null :spina_navigation_items, :page_id, false
      end
    end
  end
end
