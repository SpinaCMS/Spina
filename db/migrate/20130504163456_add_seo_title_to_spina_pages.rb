class AddSeoTitleToSpinaPages < ActiveRecord::Migration
  def change
    add_column :spina_pages, :seo_title, :string
  end
end
