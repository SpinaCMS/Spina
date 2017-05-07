# This migration comes from spina (originally 4)
class AddPasswordResetTokenToSpinaUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :spina_users, :password_reset_token, :string
    add_column :spina_users, :password_reset_sent_at, :datetime
  end
end
