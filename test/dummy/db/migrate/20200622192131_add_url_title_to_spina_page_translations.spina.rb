# This migration comes from spina (originally 20200622192008)
class AddUrlTitleToSpinaPageTranslations < ActiveRecord::Migration[6.0]
  def change
    add_column :spina_page_translations, :url_title, :string
  end
end
