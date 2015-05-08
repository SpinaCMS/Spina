module Spina
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path("../templates", __FILE__)

    def create_initializer_file
      template "spina.rb", "config/initializers/spina.rb"
    end

    def create_theme_initializer
      template "theme.rb", "config/initializers/themes/default.rb"
    end

    def copy_migrations
      rake "spina:install:migrations"
    end

    def run_migrations
      rake "db:migrate"
    end

    def copy_views
      template "application.html.erb", "app/views/layouts/default/application.html.erb"
      template "homepage.html.erb", "app/views/default/pages/homepage.html.erb"
      template "show.html.erb", "app/views/default/pages/show.html.erb"
    end

    def create_account
      name = ask("What would you like to name your website?")
      Account.create name: name, theme: 'default'
    end

    def create_user
      email = ask("Please enter an email address for your first user:")
      password = ask("Create a temporary password:")
      User.create name: 'admin', email: email, password: password, admin: true
    end

    def add_route
      route "mount Spina::Engine => '/'"
    end

  end
end