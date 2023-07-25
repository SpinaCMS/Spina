class CreateNavigationItemUrlTitleTranslationsForMobilityTableBackend < ActiveRecord::Migration[7.0]
  def change
    create_table :spina_navigation_item_translations do |t|

      # Translated attribute(s)
      t.string :url_title

      t.string  :locale, null: false
      t.references :spina_navigation_item, null: false, foreign_key: true, index: false

      t.timestamps null: false
    end

    add_index :spina_navigation_item_translations, :locale, name: :index_spina_navigation_item_translations_on_locale
    add_index :spina_navigation_item_translations, [:spina_navigation_item_id, :locale], name: :index_000e7683e9c93042c0a7a289de357c91ed220812, unique: true

  end
end
