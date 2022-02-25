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
  
  desc "Silent First deploy"
  task silent_first_deploy: :environment do
    # Silent First deploy will run the same steps as First Deploy but without prompts
    Rails::Command.invoke :generate, ["spina:install", "--first-deploy", "--silent"]
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

end
