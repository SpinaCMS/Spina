require 'tailwindcss-rails'

namespace :spina do
  namespace :tailwind do 
    desc "Build your Tailwind CSS"
    task :build do
      # Generate Tailwind config
      Rails::Generators.invoke("spina:tailwind_config", ["--force"])
      
      executable = Tailwindcss::Engine.root.join("exe/tailwindcss")
      input = Spina::Engine.root.join("app/assets/stylesheets/spina/application.tailwind.css")
      output = Rails.root.join("app/assets/builds", "spina/tailwind.css")
      config = Rails.root.join("app/assets/config/spina/tailwind.config.js")
      
      system "#{executable} -i #{input} -o #{output} -c #{config}"
    end
    
    task :watch do
      # Watch command
    end
  end
end

if Rake::Task.task_defined?("assets:precompile")
  Rake::Task["assets:precompile"].enhance(["spina:tailwind:build"])
end

if Rake::Task.task_defined?("test:prepare")
  Rake::Task["test:prepare"].enhance(["spina:tailwind:build"])
elsif Rake::Task.task_defined?("db:test:prepare")
  Rake::Task["db:test:prepare"].enhance(["spina:tailwind:build"])
end