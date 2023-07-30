module Spina
  class TailwindConfigGenerator < Rails::Generators::Base
    source_root File.expand_path("../templates", __FILE__)

    def create_tailwind_config_file
      filename = "/app/assets/config/spina/tailwind.config.js"
      insert_into_file ".gitignore", filename
      template filename
    end
  end
end
