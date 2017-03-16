class DropSpinaColors < ActiveRecord::Migration
  def change
    drop_table :spina_colors
  end
end
