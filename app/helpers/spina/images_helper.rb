module Spina
  module ImagesHelper

    # We wrap some Rails logic inside our own helper method
    # because the resolve directive in ActiveStorage's routes
    # doesn't work outside the main app in 5.2.0.rc2
    def variant(file, options)
      file.variant(options).processed.service_url
    end

  end
end