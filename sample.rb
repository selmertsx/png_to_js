# coding: UTF-8
require "zlib"
require "pry"

depth, color_type = 8, 2
width = 100
# グラデーションのベタデータ
line = ("a".."z").to_a.sample(width).map(&:ord)
# チャンクのバイト列生成関数
def chunk(type, data)
  [data.bytesize, type, data, Zlib.crc32(type + data)].pack("NA4A*N")
end
# ファイルシグニチャ
print "\x89PNG\r\n\x1a\n"
# ヘッダ
print chunk("IHDR", [width, 1, 8, 2, 0, 0, 0].pack("NNCCCCC"))
# 画像データ
img_data = ([0] + line.flatten).pack("C*")
print chunk("IDAT", Zlib::Deflate.deflate(img_data))
# 終端
print chunk("IEND", "")
