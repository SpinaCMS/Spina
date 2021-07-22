Spina.configure do |config|
  # Set locales
  config.locales = [:en]
  # Run `rake spina:update_translations` after you add any new locale.

  # Important Note
  # ==============

  # You MUST restart your server before changes to this file
  # will take effect.

  # Specify a backend path. Defaults to /admin.
  # config.backend_path = 'admin'
  
  # The parent controller all frontend Spina controllers inherit from
  # Defaults to ApplicationController
  # config.frontend_parent_controller = "ApplicationController"
  
  # Background jobs
  # ===============
  # 
  # By default, all background jobs are queued as :default
  # config.queues.page_updates = :default

  # Confetti
  # ===============
  # 
  # For people who don't appreciate confetti, you can disable that here 
  # config.party_pooper = true

  # Pages Options
  # ===============

  # Note that you might need to remove cached asset after changing this value
  # config.max_page_depth = 5
end
