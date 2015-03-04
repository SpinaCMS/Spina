class RemoveThemeFromSpinaAccounts < ActiveRecord::Migration
  def change
    remove_column :spina_accounts, :theme
  end
end
