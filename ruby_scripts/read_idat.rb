require "zlib"
require "pry"

png = File.open("images/sample.png", "r:ASCII-8BIT")
png_binary = png.read
post_idat = /IDAT/.match(png_binary).post_match
idat = /IEND/.match(post_idat).pre_match
zstream = Zlib::Inflate.new
buf = zstream.inflate(idat)
puts buf
