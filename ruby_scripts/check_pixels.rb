require 'RMagick'
require 'pry'
include Magick

decompressed_image = ImageList.new("images/decompress.png")
image = ImageList.new("images/sample.png")

File.open("script_from_pngs/from_webp.js", "w") do |f|
  f.write(decompressed_image.export_pixels_to_str.scan(/.{1,3}/).map(&:chr).join.gsub("\s{1,2}",""))
end

File.open("script_from_pngs/png.js", "w") do |f|
  f.write(image.export_pixels_to_str.scan(/.{1,3}/).map(&:chr).join.gsub("\s{1,2}",""))
end
