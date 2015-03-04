class AddSpamToSpinaInquiries < ActiveRecord::Migration
  def change
    add_column :spina_inquiries, :spam, :boolean
  end
end
