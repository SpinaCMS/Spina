module Spina
  module Attachable
    extend ActiveSupport::Concern
    
    included do
      has_one_attached :file
      
      scope :with_filename, ->(query) do
        joins(:file_blob).where(
          "LOWER(active_storage_blobs.filename) LIKE LOWER(?)",
          "%" + Image.sanitize_sql_like(query) + "%"
        )
      end
    end
    
    def name
      file&.filename.to_s
    end
    
  end
end