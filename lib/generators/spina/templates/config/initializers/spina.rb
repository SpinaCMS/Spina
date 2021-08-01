Spina.configure do |config|  
  # Locales
  # ===============
  # All locales your content should be available in.
  # config.locales = [I18n.default_locale]

  # Backend path
  # ===============
  # Specify a backend path. Defaults to /admin.
  # config.backend_path = 'admin'
  
  # Frontend routes
  # ===============
  # Uncomment the config below to disable all frontend routes.
  # You'll have to write your own.
  # config.disable_frontend_routes = true
  
  # Embedded image size
  # ===============
  # Images that are inserted in rich text fields are resized automatically.
  # You can define your desired dimensions here.
  # config.embedded_image_size = [2000, 2000]
  
  # Parent controller
  # ===============
  # The parent controller all frontend Spina controllers inherit from
  # Defaults to ApplicationController
  # config.frontend_parent_controller = "ApplicationController"
  
  # Authentication
  # ===============
  # Specify the module that handles authentication
  # You can swap this out for something like Devise, or you can use your own authentication.
  # The default is Spina::Authentication::Sessions and includes basic user management
  # config.authentication = "Spina::Authentication::Sessions"
  
  # API
  # ===============
  # Set an API key to activate Spina's API. 
  # It's highly recommended to use Rails credentials to store this API key.
  # config.api_key = Rails.application.credentials.spina_api_key
  # config.api_path = 'api'
  
  # Background jobs
  # ===============
  # By default, all background jobs are queued as :default
  # config.queues.page_updates = :default

  # Confetti
  # ===============
  # For people who don't appreciate confetti, you can disable that here.
  # config.party_pooper = true

  # Pages Options
  # ===============

  # Note that you might need to remove cached asset after changing this value
  # config.max_page_depth = 5

  # Transliterations
  # ===============
  # Set provided transliterations for normalizing url slugs
  # %i( bulgarian cyrillic danish german greek latin macedonian norwegian 
  #     romanian russian serbian spanish swedish ukrainian vietnamese)
  # config.transliterations = %i(latin)
end
