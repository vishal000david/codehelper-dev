require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  # For testing, upload files to local `tmp` folder.
  if Rails.env.test? || Rails.env.cucumber?
    config.storage = :file
    config.enable_processing = false
    config.root = "#{Rails.root}/tmp"
  else
    config.storage = :fog
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      :provider              => 'AWS',
      :aws_access_key_id     => 'AKIAJ6EW33TE24Y6J4LA',
      :aws_secret_access_key => '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',
      :region                => 'us-west-2'
    }
    config.fog_directory    = 'codehelperfiles'
    config.fog_public       = true
    config.asset_host       = "https://s3-us-west-2.amazonaws.com/codehelperfiles"
  end

  config.cache_dir = "#{Rails.root}/tmp/uploads"
end
Rack::Utils.multipart_part_limit = 0