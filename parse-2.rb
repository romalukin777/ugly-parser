require "json"

lines = File.readlines("parsed-1.txt").map(&:strip)
output = File.open("parsed-2.txt", "w")
lines.each do |line|
  data = JSON.parse(line)
  new_data = {}
  data.each do |key, value|
	new_data[key.gsub(/\(\d+\)/, "")] = value
  end
  output.puts new_data.to_json
end
output.close
