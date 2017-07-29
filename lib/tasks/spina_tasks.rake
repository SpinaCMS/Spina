namespace :spina do

  desc "Make sure everything is in place and your theme can be activated"
  task bootstrap: :environment do
    # Get theme from Account model
    account = Spina::Account.first

    # Activate the theme and generate pages
    Spina::ThemeActivator.new(account.theme).activate!
  end

  desc "Update translations after adding locales"
  task update_translations: :environment do
    Spina.locales.each do |locale|
      I18n.locale = locale
      Spina::Page.find_each(&:save!)
    end
  end

end
