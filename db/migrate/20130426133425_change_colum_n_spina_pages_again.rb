class ChangeColumNSpinaPagesAgain < ActiveRecord::Migration
  def change
    change_column :spina_pages, :parent_id, :integer
  end
end
