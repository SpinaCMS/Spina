class CreateSpinaSpinaFiles < ActiveRecord::Migration
  def change
    create_table :spina_spina_files do |t|
      t.string :file

      t.timestamps
    end
  end
end
