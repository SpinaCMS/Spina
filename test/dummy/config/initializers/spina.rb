Spina.configure do |config|
  config.NEGATIVE_CAPTCHA_SECRET = '3e795c8643062d248298d99a899607952631b6733ecba312745cce0507e7602a4b752828a2c109461b40bfc44ca014a6b8bee80e2a6f792a3ee54b286bbc7366'

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
