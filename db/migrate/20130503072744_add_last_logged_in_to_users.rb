class AddLastLoggedInToUsers < ActiveRecord::Migration
  def change
    add_column :spina_users, :last_logged_in, :date
  end
end
