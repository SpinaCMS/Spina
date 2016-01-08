class CreateSpinaRewriteRules < ActiveRecord::Migration
  def change
    create_table :spina_rewrite_rules do |t|
      t.string :old_path
      t.string :new_path
      t.timestamps
    end
  end
end