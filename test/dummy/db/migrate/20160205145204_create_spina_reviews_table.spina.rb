# This migration comes from spina (originally 20140331111225)
class CreateSpinaReviewsTable < ActiveRecord::Migration
  def change
    create_table :spina_reviews do |t|
      t.string :name
      t.integer :rating, null: false
      t.text :explanation
      t.date :confirmed_at
      t.timestamps
    end
  end
end
