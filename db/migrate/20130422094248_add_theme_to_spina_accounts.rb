class AddThemeToSpinaAccounts < ActiveRecord::Migration
  def change
    add_column :spina_accounts, :theme, :string
  end
end
