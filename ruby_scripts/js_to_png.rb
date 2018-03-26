require "zlib"
require "pry"

jsfile = File.open("jquery_min.js", "r")
code = jsfile.read

# cwebpの制限
MAXIMUM_PIXEL_SIZE = 16383.0
width = MAXIMUM_PIXEL_SIZE
height = (code.length / MAXIMUM_PIXEL_SIZE).ceil
depth, color_type = 8, 2

array_code = code.scan(/.{1,16383}/)

raw_data = array_code.map do |data|
  data.ljust(width, "/").each_codepoint.to_a.map {|x| [x, x, x]}
end

# チャンクのバイト列生成関数
def chunk(type, data)
  [data.bytesize, type, data, Zlib.crc32(type + data)].pack("NA4A*N")
end

File.open("images/sample.png", "w", encoding: Encoding::ASCII_8BIT ) do |f|
  f << "\x89PNG\r\n\x1a\n"
  f << chunk("IHDR", [width, height, 8, 2, 0, 0, 0].pack("NNCCCCC"))
  img_data = raw_data.map {|line| ([0] + line.flatten).pack("C*") }.join
  f << chunk("IDAT", Zlib::Deflate.deflate(img_data))
  f << chunk("IEND", "")
end
