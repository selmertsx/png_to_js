require "zlib"
require "pry"

jsfile = File.open("angular.min.js", "r")
code = jsfile.read.gsub("\n", "")

# cwebpの制限
MAXIMUM_PIXEL_SIZE = 16383.0
width = MAXIMUM_PIXEL_SIZE
height = (code.length / MAXIMUM_PIXEL_SIZE).ceil

array_code = code.scan(/.{1,16383}/)
raw_data = array_code.map do |data|
  data.ljust(width, " ").each_codepoint.to_a
end

# チャンクのバイト列生成関数
def chunk(type, data)
  [data.bytesize, type, data, Zlib.crc32(type + data)].pack("NA4A*N")
end

File.open("images/sample.png", "w", encoding: Encoding::ASCII_8BIT ) do |f|
  f << "\x89PNG\r\n\x1a\n"
  f << chunk("IHDR", [width, height, 8, 0, 0, 0, 0].pack("NNCCCCC"))
  img_data = raw_data.map {|line| ([0] + line.flatten).pack("C*") }.join
  f << chunk("IDAT", Zlib::Deflate.deflate(img_data))
  f << chunk("IEND", "")
end
