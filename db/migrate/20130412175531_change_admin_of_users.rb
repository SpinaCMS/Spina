class ChangeAdminOfUsers < ActiveRecord::Migration
  def change
    change_column :spina_users, :admin, :boolean, default: false
  end
end
