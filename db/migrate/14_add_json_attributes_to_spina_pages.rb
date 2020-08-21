class AddJsonAttributesToSpinaPages < ActiveRecord::Migration[5.2]
  def change
    add_column :spina_pages, :json_attributes, :jsonb
  end
end
