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
  
  # Background jobs
  # ===============
  # By default, all background jobs are queued as :default
  # config.queues.page_updates = :default

  # Confetti
  # ===============
  # For people who don't appreciate confetti, you can disable that here.
  # config.party_pooper = true
end
