# This migration comes from spina (originally 20140711154425)
class AddRobotsAllowedToSpinaAccounts < ActiveRecord::Migration
  def change
    add_column :spina_accounts, :robots_allowed, :boolean, default: false
  end
end
