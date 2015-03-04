# This migration comes from spina (originally 20130503072744)
class AddLastLoggedInToUsers < ActiveRecord::Migration
  def change
    add_column :spina_users, :last_logged_in, :date
  end
end
