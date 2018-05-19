class MigratePhotosToImages < ActiveRecord::Migration[5.2]
  def up
    Rake::Task['spina:photo_to_image'].invoke
  end

  def down
  end
end
