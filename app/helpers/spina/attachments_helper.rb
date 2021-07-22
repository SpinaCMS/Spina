module Spina
  module AttachmentsHelper

    def file_url(file)
      main_app.url_for(file)
    end

  end
end