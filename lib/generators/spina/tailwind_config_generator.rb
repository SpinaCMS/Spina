module Spina
  class TailwindConfigGenerator < Rails::Generators::Base
    source_root File.expand_path("../templates", __FILE__)

    CONFIG_FILE = "app/assets/config/spina/tailwind.config.js"
    IGNORE_TEXT = <<~TEXT.chomp
      # Ignore auto-generated Spina Tailwind CSS configuration
      /#{CONFIG_FILE}
    TEXT

    def create_tailwind_config_file
      template CONFIG_FILE

      unless File.read(".gitignore").include?(IGNORE_TEXT)
        append_to_file ".gitignore", <<~TEXT
          \n
          #{IGNORE_TEXT}
        TEXT
      end
    end
  end
end
