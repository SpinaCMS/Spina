module Spina
  class DeployGenerator < Rails::Generators::Base

    def run_migrations
      rake 'db:migrate'
    end

    def create_account
      return if Account.exists? && !no?('An account already exists. Skip? [Yn]')
      name = ask('What would you like to name your website?')
      account = Account.first_or_create.update_attribute(:name, name)
    end

    def set_theme
      account = Account.first
      return if account.theme.present? && !no?("Theme '#{account.theme} is set. Skip? [Yn]")

      themes = Spina::Theme.all.map(&:name)

      theme = begin
                theme = account.theme || themes.first
                theme = ask("What theme do you want to use? (#{themes.join('/')}) [#{theme}]").presence || theme
              end until theme.in? themes

      account.update_attribute(:theme, theme)
    end


    def create_user
      return if User.exists? && !no?('A user already exists. Skip? [Yn]')
      email = ask('Please enter an email address for your first user:')
      password = ask('Create a temporary password:', echo: false)
      User.create name: 'admin', email: email, password: password, admin: true
    end

    def bootstrap_spina
      rake 'spina:bootstrap'
    end

  end
end
