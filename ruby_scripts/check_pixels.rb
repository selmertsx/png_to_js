require 'RMagick'
require 'pry'
include Magick

decompressed_image = ImageList.new("images/decompress.png")
image = ImageList.new("images/sample.png")

puts decompressed_image.export_pixels_to_str.scan(/.{1,3}/).map(&:chr).join
puts image.export_pixels_to_str.scan(/.{1,3}/).map(&:chr).join
