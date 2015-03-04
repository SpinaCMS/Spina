# This migration comes from spina (originally 20130422194143)
class ChangeDefaultValueColumnArchivedInquiries < ActiveRecord::Migration
  def change
    change_column :spina_inquiries, :archived, :boolean, default: false
  end
end
