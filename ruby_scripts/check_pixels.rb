require 'RMagick'
require 'pry'
include Magick

decompressed_image = ImageList.new("images/decompress.png")
image = ImageList.new("images/sample.png")

dpng_js = decompressed_image.export_pixels_to_str.scan(/.{1,3}/).map(&:chr).join.gsub("\s{1,2}","")
File.open("script_from_pngs/from_webp.js", "w") do |f|
  f.write(dpng_js)
end

png_js = image.export_pixels_to_str.scan(/.{1,3}/).map(&:chr).join.gsub("\s{1,2}","")
File.open("script_from_pngs/png.js", "w") do |f|
  f.write(png_js)
end
