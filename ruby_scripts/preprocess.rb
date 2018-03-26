
require "pry"

code = ""
File.open("angular.min.js", "r") do |f|
  code = f.readlines.map(&:chop).join
end

File.open("fixed_angular.min.js", "w") do |f|
  f.write(code)
end
