# This migration comes from spina (originally 20130504163456)
class AddSeoTitleToSpinaPages < ActiveRecord::Migration
  def change
    add_column :spina_pages, :seo_title, :string
  end
end
