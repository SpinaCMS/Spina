require "tailwindcss/ruby"

namespace :spina do
  namespace :tailwind do
    def spina_tailwind_compile_command
      [
        Tailwindcss::Ruby.executable,
        "-i", Rails.root.join("app/assets/stylesheets/spina/application.tailwind.css").to_s,
        "-o", Rails.root.join("app/assets/builds/spina/tailwind.css").to_s
      ]
    end

    desc "Build your Tailwind CSS"
    task build: :environment do
      Rails::Generators.invoke("spina:tailwind_config", ["--force"])
      command = spina_tailwind_compile_command
      system *command
    end

    task watch: :environment do
      Rails::Generators.invoke("spina:tailwind_config", ["--force"])
      command = spina_tailwind_compile_command
      command << "-w"
      system *command
    end
  end
end

if Rake::Task.task_defined?("assets:precompile")
  Rake::Task["assets:precompile"].enhance(["spina:tailwind:build"])
end
