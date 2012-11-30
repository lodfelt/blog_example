# encoding: utf-8

class ArticleUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick

  if Rails.env.test? or Rails.env.cucumber?
    storage :file
  else
    storage :fog
  end
  include CarrierWave::MimeTypes
  process :set_content_type

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :large do
    process resize_to_fill: [640, 360]
  end

  version :inline do
    process resize_to_fill: [410, 270]
  end

  version :thumb do
    process resize_to_fill: [270, 180]
  end

  version :small do
    process resize_to_fill: [68, 45]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

end
