# This migration comes from spina (originally 20130426133425)
class ChangeColumNSpinaPagesAgain < ActiveRecord::Migration
  def change
    change_column :spina_pages, :parent_id, :integer
  end
end
