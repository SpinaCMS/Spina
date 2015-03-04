# This migration comes from spina (originally 20130412175531)
class ChangeAdminOfUsers < ActiveRecord::Migration
  def change
    change_column :spina_users, :admin, :boolean, default: false
  end
end
