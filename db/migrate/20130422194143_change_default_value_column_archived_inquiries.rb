class ChangeDefaultValueColumnArchivedInquiries < ActiveRecord::Migration
  def change
    change_column :spina_inquiries, :archived, :boolean, default: false
  end
end
