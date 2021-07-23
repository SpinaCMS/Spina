class AddUrlTitleToSpinaPageTranslations < ActiveRecord::Migration[5.2]
  def change
    add_column :spina_page_translations, :url_title, :string
  end
end
