class ChangeColumnSpinaUsers < ActiveRecord::Migration
  def change
    change_column :spina_users, :last_logged_in, :datetime
  end
end
