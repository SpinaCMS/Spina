Spina.configure do |config|
  config.NEGATIVE_CAPTCHA_SECRET = '<%= Spina.config.try(:NEGATIVE_CAPTCHA_SECRET) || SecureRandom.hex(64) %>'

  # Set locales
  config.locales = [:en]

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
end
