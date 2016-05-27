require 'rake'
Spina::Engine.load_tasks

module Spina
  class InstallGenerator < Rails::Generators::Base

    source_root File.expand_path("../templates", __FILE__)

    def create_initializer_file
      return if Rails.env.production?
      template 'config/initializers/spina.rb'
    end

    def create_carrierwave_initializer_file
      return if Rails.env.production?
      template 'config/initializers/carrierwave.rb'
    end

    def add_route
      return if Rails.env.production?
      return if Rails.application.routes.routes.detect { |route| route.app.app == Spina::Engine }
      route "mount Spina::Engine => '/'"
    end

    def copy_migrations
      return if Rails.env.production?
      rake 'spina:install:migrations'
    end

    def run_migrations
      rake 'db:migrate'
    end

    def create_account
      return if Account.exists? && !no?('An account already exists. Skip? [Yn]')
      name = Account.first.try(:name) || 'MySite'
      name = ask("What would you like to name your website? [#{name}]").presence || name
      account = Account.first_or_create.update_attribute(:name, name)
    end

    def set_theme
      account = Account.first
      return if account.theme.present? && !no?("Theme '#{account.theme} is set. Skip? [Yn]")

      theme = begin
                theme = account.theme || themes.first
                theme = ask("What theme do you want to use? (#{themes.join('/')}) [#{theme}]").presence || theme
              end until theme.in? themes

      account.update_attribute(:theme, theme)
    end

    def copy_template_files
      return if Rails.env.production?
      theme = Account.first.theme
      template "config/initializers/themes/#{theme}.rb"
      directory "app/assets/stylesheets/#{theme}"
      directory "app/views/#{theme}"
      directory "app/views/layouts/#{theme}"
    end

    def create_user
      return if User.exists? && !no?('A user already exists. Skip? [Yn]')
      email = 'user@domain.com'
      email = ask("Please enter an email address for your first user: [#{email}]").presence || email
      password = 'password'
      password = ask("Create a temporary password: [#{password}]", echo: false).presence || password
      User.create name: 'admin', email: email, password: password, admin: true
    end

    def bootstrap_spina
      rake 'spina:bootstrap'
    end

    def seed_demo_content
      theme_name = Account.first.theme
      if theme_name == 'demo' && !no?('Seed example content? [Yn]')
        Rake::Task['spina:seed_demo_content'].invoke
      end
    end

    private

      def themes
        Rails.env.production? ? Spina::Theme.all.map(&:name) : ['default', 'demo']
      end

  end
end
