Spina::Engine.configure do
  config.NEGATIVE_CAPTCHA_SECRET = '<%= SecureRandom.hex(64) %>'

  # If you want to use s3 to store uploads
  # config.storage = :s3
  # config.aws_region = "eu-west-1"
  # config.aws_access_key_id = "abc123"
  # config.aws_secret_key = "abc123"
  # config.s3_bucket = "mybucket"
end