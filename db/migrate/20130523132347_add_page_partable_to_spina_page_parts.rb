# This migration comes from spina (originally 20130523132347)
class AddPagePartableToSpinaPageParts < ActiveRecord::Migration
  
  module Spina
    def self.table_name_prefix
      'spina_'
    end

    class PagePart < ActiveRecord::Base
      belongs_to :page
      belongs_to :page_partable, polymorphic: true

      belongs_to :photo
      belongs_to :file
      has_many :files
      has_many :galleries
      has_many :photos, through: :galleries
    end

    class Gallery < ActiveRecord::Base
      belongs_to :photo
      belongs_to :page_part
    end

    class Photo < ActiveRecord::Base
      has_many :page_parts, through: :galleries

      has_many :page_parts, as: :page_partable
      has_and_belongs_to_many :photo_collections, join_table: 'spina_photo_collections_photos'
    end

    class PhotoCollection < ActiveRecord::Base
      has_one :page_part, as: :page_partable
      has_and_belongs_to_many :photos, join_table: 'spina_photo_collections_photos'
    end

    class File < ActiveRecord::Base
      belongs_to :page_part

      has_many :page_parts, as: :page_partable
      has_and_belongs_to_many :file_collections, join_table: 'spina_file_collections_files'
    end

    class FileCollection < ActiveRecord::Base
      has_one :page_part, as: :page_partable
      has_and_belongs_to_many :files, join_table: 'spina_file_collections_files'
    end

  end


  def up
    change_table :spina_page_parts do |t|
      t.references :page_partable, polymorphic: true
    end

    create_table :spina_photo_collections do |t|
      t.timestamps
    end

    create_table :spina_photo_collections_photos do |t|
      t.integer :photo_collection_id
      t.integer :photo_id
    end

    create_table :spina_file_collections do |t|
      t.timestamps
    end

    create_table :spina_file_collections_files do |t|
      t.integer :file_collection_id
      t.integer :file_id
    end

    Spina::PagePart.reset_column_information
    Spina::PagePart.all.each do |part|
      case part.content_type
      when "photo"
        puts part.inspect
        if part.photo_id
          part.update_attributes!({ page_partable_type: "Spina::Photo", page_partable_id: part.photo.id }, without_protection: true)
        else
          part.destroy
        end
      when "photos"
        photo_collection = Spina::PhotoCollection.create
        part.update_attributes!({ page_partable_type: "Spina::PhotoCollection", page_partable_id: photo_collection.id }, without_protection: true)
        part.photos.each do |photo|
          photo_collection.photos << photo
        end
      when "file"
        # puts part.file.inspect
        part.update_attributes!({ page_partable_type: "Spina::File", page_partable_id: nil }, without_protection: true)
      when "files"
        file_collection = Spina::FileCollection.create
        part.update_attributes!({ page_partable_type: "Spina::FileCollection", page_partable_id: file_collection.id }, without_protection: true)
        part.files.each do |file|
          file_collection.files << file
        end
      when "text"
        part.update_attributes!({ page_partable_type: "Text" }, without_protection: true)
      when "line"
        part.update_attributes!({ page_partable_type: "Line" }, without_protection: true)
      end
    end

    drop_table :spina_galleries
    remove_column :spina_page_parts, :content_type
    remove_column :spina_page_parts, :photo_id
    remove_column :spina_files, :page_part_id

  end

  def down

    change_table :spina_page_parts do |t|
      t.remove_references :page_partable, polymorphic: true
    end

    drop_table :spina_photo_collections
    drop_table :spina_photo_collections_photos
    drop_table :spina_file_collections
    drop_table :spina_file_collections_files

    create_table :spina_galleries do |t|
      t.integer :photo_id
      t.integer :page_part_id

      t.timestamps
    end    

    add_column :spina_page_parts, :content_type
    add_column :spina_page_parts, :photo_id
    add_column :spina_files, :page_part_id    
  end

end