CarrierWave.configure do |config|
  config.storage = :file

  # Use S3 if you want
  # config.fog_credentials = {
  #   provider:               'AWS',
  #   region:                 '',
  #   aws_access_key_id:      '',
  #   aws_secret_access_key:  ''
  # }
  # config.storage = :fog
  # config.fog_directory  = ''
  # config.fog_public     = true
  # config.fog_attributes = { 'Cache-Control' => 'max-age=315576000' }

  config.enable_processing = !Rails.env.test?
end