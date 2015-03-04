class ChangeColumnsPages < ActiveRecord::Migration
  def change
    change_column :spina_pages, :show_in_menu, :boolean, default: true
    change_column :spina_pages, :deletable, :boolean, default: true
  end
end
