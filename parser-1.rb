require "json"
require "base64"
require "cgi"
require "php_serialize"

def parse_log_line(line)
  PHP.unserialize(Base64.decode64(line.strip))
rescue
  {}
end

all_data = {}
logs = File.readlines("logs.jpg")
logs.each do |log|
  data = parse_log_line(log)
  next unless data["frontend_tmp"]
  next unless data["data"]
  id = data["frontend_tmp"]
  parsed = CGI.parse(data["data"])
  all_data[id] ||= {}
  all_data[id].merge!(parsed)
end

output = File.open("parsed-1.txt", "w")
all_data.each do |id, data|
  output.puts data.to_json
end
putput.close
