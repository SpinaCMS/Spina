CarrierWave.configure do |config|
  config.storage = :file

  # Use S3 if you want
  # cfg.storage = :fog
  # cfg.fog_credentials = {
  #   provider:               'AWS',
  #   region:                 '',
  #   aws_access_key_id:      '',
  #   aws_secret_access_key:  ''
  # }
  # cfg.fog_directory  = ''
  # cfg.fog_public     = true
  # cfg.fog_attributes = { 'Cache-Control' => 'max-age=315576000' }

  config.enable_processing = !Rails.env.test?
end