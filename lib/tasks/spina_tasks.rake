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
    Spina::Photo.find_each do |photo|
      image = Spina::Image.create(media_folder_id: photo.media_folder_id)
      image.file.attach(io: photo.file.sanitized_file.file, filename: photo.name)
      photo.update_column(:image_id, image.id)
    end

    Spina::PagePart.where(page_partable_type: 'Spina::Photo').find_each do |page_part|
      if page_part.page_partable.present?
        page_part.update_columns(
          page_partable_type: 'Spina::Image',
          page_partable_id: page_part.page_partable.image_id
        )
      else
        page_part.update_column(:page_partable_type, 'Spina::Image')
      end
    end

    Spina::StructurePart.where(structure_partable_type: 'Spina::Photo').find_each do |structure_part|
      if structure_part.structure_partable.present?
        structure_part.update_columns(
          structure_partable_type: 'Spina::Image',
          structure_partable_id: structure_part.structure_partable.image_id
        )
      else
        structure_part.update_column(:structure_partable_type, 'Spina::Image')
      end
    end

    Spina::PagePart.where(page_partable_type: 'Spina::PhotoCollection').find_each do |page_part|
      if page_part.partable.present?
        image_collection = Spina::ImageCollection.create
        page_part.partable.photos.each do |photo|
          image_collection.images << Spina::Image.find(photo.image_id)
        end
        page_part.update_columns(
          page_partable_type: 'Spina::ImageCollection',
          page_partable_id: image_collection.id
        )
      else
        page_part.update_column :page_partable_type, 'Spina::ImageCollection'
      end
    end

    Spina::StructurePart.where(structure_partable_type: 'Spina::PhotoCollection').find_each do |structure_part|
      if structure_part.partable.present?
        image_collection = Spina::ImageCollection.create
        structure_part.partable.photos.each do |photo|
          image_collection.images << Spina::Image.find(photo.image_id)
        end
        structure_part.update_columns(
          structure_partable_type: 'Spina::ImageCollection',
          structure_partable_id: image_collection.id
        )
      else
        structure_part.update_column :structure_partable_type, 'Spina::PhotoCollection'
      end
    end
    exit 0
  end
end
