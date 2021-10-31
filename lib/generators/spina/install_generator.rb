module Spina
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path("../templates", __FILE__)

    def create_initializer_file
      return if Rails.env.production?
      template 'config/initializers/spina.rb'
    end

    def create_mobility_initializer_file
      return if Rails.env.production?
      template 'config/initializers/mobility.rb'
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
      return if ::Spina::Account.exists? && !no?('An account already exists. Skip? [Yn]')
      name = ::Spina::Account.first.try(:name) || 'MySite'
      if talkative_install?
        name = ask("What would you like to name your website? [#{name}]").presence || name
      end
      account = ::Spina::Account.first_or_create.update_attribute(:name, name)
    end

    def set_theme
      account = ::Spina::Account.first
      return if account.theme.present? && !no?("Theme '#{account.theme} is set. Skip? [Yn]")

      theme = account.theme || themes.first
      if talkative_install?
        theme = begin
                  theme = ask("What theme do you want to use? (#{themes.join('/')}) [#{theme}]").presence || theme
                end until theme.in? themes
      end

      account.update_attribute(:theme, theme)
    end

    def copy_template_files
      theme = ::Spina::Account.first.theme
      if theme.in? ['default', 'demo']
        template "config/initializers/themes/#{theme}.rb"
        directory "app/views/#{theme}"
        directory "app/views/layouts/#{theme}"
      end
      Spina::THEMES.clear
      Dir[Rails.root.join('config', 'initializers', 'themes', '*.rb')].each { |file| load file }
    end

    def create_user
      return if ::Spina::User.exists? && !no?('A user already exists. Skip? [Yn]')

      email = 'admin@domain.com'
      if talkative_install?
        email = ask("Please enter an email address for your first user: [#{email}]").presence || email
      end
      password = 'password'
      if talkative_install?
        password = ask("Create a temporary password: [#{password}]").presence || password
      end
      @temporary_password = password
      ::Spina::User.create name: 'admin', email: email, password: password, admin: true
    end

    def bootstrap_spina
      rake 'spina:bootstrap'
    end

    def feedback
      puts
      puts '    Your Spina site has been succesfully installed! '
      puts
      puts '    Restart your server and visit http://localhost:3000 in your browser!'
      puts "    The admin backend is located at http://localhost:3000/#{Spina.config.backend_path}."
      puts
      puts "    Site name      :  #{::Spina::Account.first.name}"
      puts "    Active theme   :  #{::Spina::Account.first.theme}"
      puts "    User email     :  #{::Spina::User.first.email}"
      puts "    User password  :  #{@temporary_password}"
      puts
    end

    private

      def themes
        themes = Spina::Theme.all.map(&:name)
        themes | ['default', 'demo']
      end

      def talkative_install?
        !cli_args.key?('silent')
      end

      def cli_args
        # See https://stackoverflow.com/a/59256782/2595513
        Hash[ ARGV.join(' ').scan(/--?([^=\s]+)(?:="(.*?)"+)?/) ]
      end

  end
end
