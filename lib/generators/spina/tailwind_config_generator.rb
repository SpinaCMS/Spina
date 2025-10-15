module Spina
  class TailwindConfigGenerator < Rails::Generators::Base
    source_root File.expand_path("../templates", __FILE__)

    def create_tailwind_config_file
      filename = "app/assets/config/spina/application.tailwind.css"
      template filename
      insert_into_file ".gitignore", <<~TEXT

        # Ignore auto-generated Spina Tailwind CSS configuration
        /#{filename}
      TEXT
    end
  end
end
