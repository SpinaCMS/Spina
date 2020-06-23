class AddUrlTitleToSpinaPageTranslations < ActiveRecord::Migration[6.0]
  def change
    add_column :spina_page_translations, :url_title, :string
  end
end
