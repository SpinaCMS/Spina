class ChangeColumnStommeOnzin < ActiveRecord::Migration
  def change
    remove_column :spina_pages, :position
    add_column :spina_pages, :position, :integer
  end
end
