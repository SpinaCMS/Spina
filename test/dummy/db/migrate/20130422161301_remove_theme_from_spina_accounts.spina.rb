# This migration comes from spina (originally 20130422161041)
class RemoveThemeFromSpinaAccounts < ActiveRecord::Migration
  def change
    remove_column :spina_accounts, :theme
  end
end
