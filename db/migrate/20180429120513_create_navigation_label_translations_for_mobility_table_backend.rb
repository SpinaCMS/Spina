class CreateNavigationLabelTranslationsForMobilityTableBackend < ActiveRecord::Migration[5.1]
  def change
    create_table :spina_navigation_translations do |t|

      # Translated attribute(s)
      t.string :label

      t.string  :locale, null: false
      t.integer :spina_navigation_id, null: false

      t.timestamps null: false
    end

    add_index :spina_navigation_translations, :spina_navigation_id, name: :index_spina_navigation_translations_on_spina_navigation_id
    add_index :spina_navigation_translations, :locale, name: :index_spina_navigation_translations_on_locale
    add_index :spina_navigation_translations, [:spina_navigation_id, :locale], name: :index_1177c363a7dedc0f63a4c192c3449fe4ea43b8ac, unique: true

  end
end
