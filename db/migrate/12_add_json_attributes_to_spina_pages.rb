class AddJsonAttributesToSpinaPages < ActiveRecord::Migration[6.0]
  def change
    add_column :spina_pages, :json_attributes, :jsonb
  end
end
