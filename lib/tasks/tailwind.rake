require "tailwindcss-rails"

namespace :spina do
  namespace :tailwind do
    def spina_tailwind_compile_command
      "#{Tailwindcss::Engine.root.join("exe/tailwindcss")} -i #{Spina::Engine.root.join("app/assets/stylesheets/spina/application.tailwind.css")} -o #{Rails.root.join("app/assets/builds", "spina/tailwind.css")} -c #{Rails.root.join("app/assets/config/spina/tailwind.config.js")}"
    end

    desc "Build your Tailwind CSS"
    task build: :environment do
      Rails::Generators.invoke("spina:tailwind_config", ["--force"])
      system spina_tailwind_compile_command
    end

    task watch: :environment do
      Rails::Generators.invoke("spina:tailwind_config", ["--force"])
      system "#{spina_tailwind_compile_command} -w"
    end
  end
end

if Rake::Task.task_defined?("assets:precompile")
  Rake::Task["assets:precompile"].enhance(["spina:tailwind:build"])
end
