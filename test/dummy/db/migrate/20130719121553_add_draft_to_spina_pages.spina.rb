# This migration comes from spina (originally 20130719121520)
class AddDraftToSpinaPages < ActiveRecord::Migration
  def change
    add_column :spina_pages, :draft, :boolean, default: false
  end
end
