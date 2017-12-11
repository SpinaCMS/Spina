namespace :spina do

  desc "Generate all pages based on the theme config"
  task bootstrap: :environment do
    Spina::Account.first.save
  end

  desc "Update translations after adding locales"
  task update_translations: :environment do
    Spina.locales.each do |locale|
      I18n.locale = locale
      Spina::Page.find_each(&:save!)
    end
  end

  desc "Change Photo model into Image"
  task photo_to_image: :environment do
    ids = []

    Spina::Photo.all.each do |photo|
      image = Spina::Image.create(media_folder_id: photo.media_folder_id)
      image.file.attach(io: photo.file.sanitized_file.file, filename: photo.name)
      ids << [photo.id, image.id]
    end

    Spina::PagePart.where(page_partable_type: 'Spina::Photo').all.each do |page_part|
      image = Spina::Image.find(ids.select{|i| i[0] == page_part.page_partable_id}[1])
      page_part.update_attributes(page_partable: image)
    end

    Spina::PagePart.where(page_partable_type: 'Spina::PhotoCollection').all.each do |page_part|
      image_collection = Spina::ImageCollection.create
      page_part.partable.photos.each do |photo|
        image_collection.images << Spina::Image.find(ids.select{|i| i[0] == photo.id}[1])
      end
      page_part.update_attributes(page_partable: image_collection)
    end
  end

end
