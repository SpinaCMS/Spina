class AddAccountIdToSpinaLayoutParts < ActiveRecord::Migration
  def change
    add_column :spina_layout_parts, :account_id, :integer
  end
end
