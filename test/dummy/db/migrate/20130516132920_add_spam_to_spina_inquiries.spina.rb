# This migration comes from spina (originally 20130516132913)
class AddSpamToSpinaInquiries < ActiveRecord::Migration
  def change
    add_column :spina_inquiries, :spam, :boolean
  end
end
