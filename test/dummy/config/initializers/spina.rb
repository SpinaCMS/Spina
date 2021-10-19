Spina.configure do |config|  
  # Locales
  # ===============
  # All locales your content should be available in.
  config.locales = [:en, :nl, :de]
  
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
  
  # Thumbnail image size
  # ===============
  # Thumbnail images for the API are generated using `resize_to_fill`.
  # config.thumbnail_image_size = [400, 400]
  
  # Mailers
  # ===============
  # In order to send emails, you need to set a default from address.
  # You can set an optional reply_to address as well.
  config.mailer_defaults.from = "no-reply@spinacms.com"
  # config.mailer_defaults.reply_to = "support@example.com"
  
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
  config.api_key = "dummy_api_key"
  # config.api_path = 'api'
  
  # Background jobs
  # ===============
  # By default, all background jobs are queued as :default
  # config.queues.page_updates = :default

  # Confetti
  # ===============
  # For people who don't appreciate confetti, you can disable that here.
  # config.party_pooper = true
end
