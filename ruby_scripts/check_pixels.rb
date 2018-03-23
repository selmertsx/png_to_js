require 'RMagick'
require 'pry'
include Magick

decompressed_image = ImageList.new("images/decompress.png")
image = ImageList.new("images/simple.png")

puts decompressed_image.export_pixels_to_str
puts image.export_pixels_to_str
