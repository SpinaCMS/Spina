namespace :spina do

  desc "Generate all pages based on the theme config"
  task bootstrap: :environment do
    Spina::Account.first.save
  end

  desc "Update translations after adding locales"
  task update_translations: :environment do
    Spina.locales.each do |locale|
      Mobility.with_locale(locale) do

        Spina::Page.all.order(:id).each do |page|
          page.title = page.title(fallback: Mobility.new_fallbacks[locale])
          page.save
        end

      end
    end
  end

end
