class AddSkipToFirstChildAndTemplatesToSpinaPages < ActiveRecord::Migration
  def change
    add_column :spina_pages, :skip_to_first_child, :boolean, default: false
    add_column :spina_pages, :view_template, :string
    add_column :spina_pages, :layout_template, :string
  end
end
