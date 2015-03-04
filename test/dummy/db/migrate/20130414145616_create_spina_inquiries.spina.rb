# This migration comes from spina (originally 20130414145608)
class CreateSpinaInquiries < ActiveRecord::Migration
  def change
    create_table :spina_inquiries do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.text :message
      t.boolean :archived

      t.timestamps
    end
  end
end
