# This migration comes from spina (originally 20130422094248)
class AddThemeToSpinaAccounts < ActiveRecord::Migration
  def change
    add_column :spina_accounts, :theme, :string
  end
end
