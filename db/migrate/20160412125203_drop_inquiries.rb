class DropInquiries < ActiveRecord::Migration
  def change
    drop_table :spina_inquiries
  end
end
