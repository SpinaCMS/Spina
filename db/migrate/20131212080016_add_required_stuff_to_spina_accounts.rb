class AddRequiredStuffToSpinaAccounts < ActiveRecord::Migration
  def change
    add_column :spina_accounts, :kvk_identifier, :string
    add_column :spina_accounts, :vat_identifier, :string
  end
end
