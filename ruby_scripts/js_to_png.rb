require "zlib"

width, height = 100, 20
depth, color_type = 8, 2

# グラデーションのベタデータ
line = (0...width).map {|x| [97, 97, 97] }
raw_data = [line] * height

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
