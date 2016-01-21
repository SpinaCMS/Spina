module Spina
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path("../templates", __FILE__)

    def create_initializer_file
      template 'config/initializers/spina.rb'
    end

    def create_theme_initializer
      template 'config/initializers/themes/default.rb'
    end

    def copy_migrations
      rake 'spina:install:migrations'
    end

    def run_migrations
      rake 'db:migrate'
    end

    def copy_views
      template 'app/assets/stylesheets/default/application.css.sass'
      template 'app/views/layouts/default/application.html.haml'
      template 'app/views/default/shared/_navigation.html.haml'
      template 'app/views/default/pages/homepage.html.haml'
      template 'app/views/default/pages/show.html.haml'
    end

    def create_account
      return if Account.exists?
      name = ask('What would you like to name your website?')
      Account.create name: name, theme: 'default'
    end

    def create_user
      return if User.exists?
      email = ask('Please enter an email address for your first user:')
      password = ask('Create a temporary password:')
      User.create name: 'admin', email: email, password: password, admin: true
    end

    def bootstrap_spina
      rake 'spina:bootstrap'
    end

    def add_route
      return if Rails.application.routes.routes.detect { |route| route.app.app == Spina::Engine }
      route "mount Spina::Engine => '/'"
    end

  end
end
