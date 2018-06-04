module Spina
  module FilesHelper

    def file_url(file)
      main_app.rails_service_blob_path(file.signed_id, file.filename)
    end

  end
end