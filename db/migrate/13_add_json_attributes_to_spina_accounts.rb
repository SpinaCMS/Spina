class AddJsonAttributesToSpinaAccounts < ActiveRecord::Migration[6.1]
  def change
    add_column :spina_accounts, :json_attributes, :jsonb
  end
end
