require 'image_processing/mini_magick'
class ImageUploader < Shrine
  plugin :data_uri
  plugin :determine_mime_type


  include ImageProcessing::MiniMagick
  plugin :processing
  plugin :versions
  plugin :delete_raw

  process(:store) do |io, context|
    versions = { original: io }

    io.download do |original|
      pipeline = ImageProcessing::MiniMagick.source(original)
      versions[:medium] = pipeline.resize_to_limit!(750, 750)
    end

    versions
  end

end
