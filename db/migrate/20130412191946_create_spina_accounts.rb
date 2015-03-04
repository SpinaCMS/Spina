class CreateSpinaAccounts < ActiveRecord::Migration
  def change
    create_table :spina_accounts do |t|
      t.string :name
      t.string :address
      t.string :postal_code
      t.string :city
      t.string :phone
      t.string :email
      t.text :preferences
      t.string :logo

      t.timestamps
    end
  end
end
