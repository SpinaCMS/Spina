# This migration comes from spina (originally 20130412173041)
class CreateSpinaUsers < ActiveRecord::Migration
  def change
    create_table :spina_users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.boolean :admin

      t.timestamps
    end
  end
end
