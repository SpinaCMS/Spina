class AddRobotsAllowedToSpinaAccounts < ActiveRecord::Migration
  def change
    add_column :spina_accounts, :robots_allowed, :boolean, default: false
  end
end
