# frozen_string_literal: true

class UserImageUploader < CarrierWave::Uploader::Base
  #   Include RMagick or MiniMagick support:
  include CarrierWave::RMagick
  if Rails.env.development? || Rails.env.test?
    storage :file
  else
    # S3にアップロード
    storage :fog
  end

  process convert: "jpg"
  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "user_images/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    "user_images/default_user_image.jpg"
    # "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  end

  # Process files as they are uploaded:
  # process scale: [200, 300]
  process resize_to_limit: [700, 700]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  version :thumb do
    process resize_to_fit: [100, 100]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_whitelist
    %w[jpg jpeg gif png]
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  def filename
    "#{model.id}.jpg" if original_filename
  end
end
