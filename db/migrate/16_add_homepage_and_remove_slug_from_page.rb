class AddHomepageAndRemoveSlugFromPage < ActiveRecord::Migration[7.0]
  def change
    # ADDITION
    # #is_homepage: record is homepage for themes stored in #json_attributes['themes']
    add_column :spina_pages, :is_homepage, :boolean, default: false, null: false
    add_index :spina_pages, :is_homepage

    # per https://github.com/jrochkind/attr_json#basic-use
    add_index :spina_pages, :json_attributes, using: :gin

    # DEPRECIATE!
    # per https://github.com/SpinaCMS/Spina/issues/1149#issuecomment-1332717811
    remove_column :spina_pages, :slug
  end
end
