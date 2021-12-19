namespace :spina do
  
  desc "Install Spina"
  task install: :environment do
    begin
      ActiveRecord::Base.connection
    rescue ActiveRecord::NoDatabaseError
      puts "ERROR: database does not exist, run \"rails db:create\" first"
    else
      Rails::Command.invoke :generate, ["spina:install"]
    end
  end
  
  desc "First deploy"
  task first_deploy: :environment do
    # First deploy will run the same steps as the install generator, but skips copying files
    Rails::Command.invoke :generate, ["spina:install", "--first-deploy"]
  end
  
  desc "Generate all pages based on the theme config"
  task bootstrap: :environment do
    Spina::Account.first.save
  end

  desc "Update translations after adding locales"
  task update_translations: :environment do
    Spina.locales.each do |locale|
      Mobility.with_locale(locale) do

        Spina::Page.all.order(:id).each do |page|
          page.title = page.title(fallback: I18n.fallbacks[locale])
          page.save
        end

      end
    end
  end
  
  # 
  # namespace :tailwind do
  #   
  #   desc "Compile Tailwind.css for Spina"
  #   task :compile do
  #     Dir.chdir(File.join(__dir__, "../..")) do
  #       system "npx tailwindcss@latest build -i ./app/assets/stylesheets/spina/tailwind/custom.css -o ./app/assets/stylesheets/spina/_tailwind.css -c ./app/assets/config/spina/tailwind.config.js"
  #     end
  #   end
  #   
  #   desc "Purging Tailwind classes"
  #   task purge: :environment do
  #     assets_path = "app/assets/stylesheets/spina"
  #     vendor_path = "vendor/assets/stylesheets"
  #     src = Spina::Engine.root.join(assets_path, "_tailwind.css")
  #     dest = Rails.root.join(vendor_path, "spina/_tailwind.css")
  #     
  #     # Copy Spina assets to main app
  #     FileUtils.mkdir_p Rails.root.join(vendor_path)
  #     FileUtils.cp_r Spina::Engine.root.join(assets_path), Rails.root.join(vendor_path)
  #     
  #     # Purge Tailwind classes
  #     purged = Spina::TailwindPurger.purge(File.read(src), keeping_class_names_from_files: Spina.config.tailwind_purge_content)
  #     
  #     # Overwrite Tailwind stylesheet with fewer lines
  #     File.write(dest, purged)
  #   end
  #   
  #   # Every time you execute 'rake assets:precompile'
  #   # run 'spina:tailwind:purge' first
  #   if Rake::Task.task_defined?("assets:precompile")
  #     Rake::Task['assets:precompile'].enhance ['spina:tailwind:purge']
  #   end
  # end
  # 

end
