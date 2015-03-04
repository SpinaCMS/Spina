class AddLinkUrlToSpinaPages < ActiveRecord::Migration
  def change
    add_column :spina_pages, :link_url, :string
  end
end
