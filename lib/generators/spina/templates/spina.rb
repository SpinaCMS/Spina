Spina::Engine.configure do
  config.NEGATIVE_CAPTCHA_SECRET = '<%= SecureRandom.hex(64) %>'
end
