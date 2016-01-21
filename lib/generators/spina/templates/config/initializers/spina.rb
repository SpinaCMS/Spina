Spina::Engine.configure do
  config.NEGATIVE_CAPTCHA_SECRET = '<%= Spina::Engine.config.try(:NEGATIVE_CAPTCHA_SECRET) || SecureRandom.hex(64) %>'

  # Important Note
  # ==============

  # You MUST restart your server before changes to this file
  # will take effect.

  # Specify a backend path. Defaults to /admin.
  config.backend_path = 'admin'

  # Storage Options
  # ===============

  # Please specify how you want to store photos, your logo, and
  # other files. We use CarrierWave for storage. See
  # https://github.com/denkGroot/Spina/tree/master/app/uploaders/spina

  config.storage = :file

  # If you want to use s3 to store uploads (recommended)

  # config.storage = :s3
  # config.aws_region = "eu-west-1"
  # config.aws_access_key_id = "abc123"
  # config.aws_secret_key = "abc123"
  # config.s3_bucket = "mybucket"
  # If you want to store your files localy (not recommended for
  # production, in large part because it's more difficult to ensure
  # that files are backed up in sync with your database):

end
