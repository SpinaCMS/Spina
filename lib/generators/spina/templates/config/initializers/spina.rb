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

  # Pages Options
  # ===============

  # Note that you might need to remove cached asset after changing this value
  # config.max_page_depth = 5

  # API Mode
  # ===============

  # Enable API mode to serve your pages as JSON data. This will bypass any
  # layouts/templates.
  # config.api_mode = true
end
