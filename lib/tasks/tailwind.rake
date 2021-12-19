require 'tailwindcss-rails'

SPINA_TAILWIND_COMPILE_COMMAND = "#{Tailwindcss::Engine.root.join("exe/tailwindcss")} -i #{Spina::Engine.root.join("app/assets/stylesheets/spina/application.tailwind.css")} -o #{Rails.root.join("app/assets/builds", "spina/tailwind.css")} -c #{Rails.root.join("app/assets/config/spina/tailwind.config.js")}"

namespace :spina do
  namespace :tailwind do 
    desc "Build your Tailwind CSS"
    task :build do
      Rails::Generators.invoke("spina:tailwind_config", ["--force"])
      system SPINA_TAILWIND_COMPILE_COMMAND
    end
    
    task :watch do
      Rails::Generators.invoke("spina:tailwind_config", ["--force"])
      system "#{SPINA_TAILWIND_COMPILE_COMMAND} -w"
    end
  end
end

if Rake::Task.task_defined?("assets:precompile")
  Rake::Task["assets:precompile"].enhance(["spina:tailwind:build"])
end