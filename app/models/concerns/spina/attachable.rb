module Spina
  module Attachable
    extend ActiveSupport::Concern
    
    included do
      has_one_attached :file
      
      scope :with_filename, ->(query) do
        joins(:file_blob).where(
          "active_storage_blobs.filename ILIKE ?",
          "%" + Image.sanitize_sql_like(query) + "%"
        )
      end

      scope :with_library_path, ->(query) do
        folder_name, file_name = query.split("/")
        unless file_name
          file_name = folder_name
          folder_name = nil
        end
  
        relation = joins(:file_blob).where(
          "active_storage_blobs.filename ILIKE ?",
          "%" + Image.sanitize_sql_like(file_name) + "%"
        )
  
        if folder_name
          relation.joins(:media_folder).where("spina_media_folders.name = ?", folder_name)
        else
          relation
        end
      end
    end
    
    def name
      file&.filename.to_s
    end
    
  end
end
