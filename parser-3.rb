require "json"

lines = File.readlines("parsed-2.txt").map(&:strip)
cc_keys = ["payment[cc_number]", "payment[cc_exp_month]", "payment[cc_exp_year]", "payment[cc_cid]"]
name_keys = ["billing[firstname]", "billing[lastname]"]
address_keys = ["billing[street][]", "billing[region_id]", "billing[postcode]", "billing[country_id]", "billing[telephone]"]

def parse(json, keys)
  data = []
  keys.each do |key|
    item = json[key]
	next unless item
    data << item.first
  end
  data
end

output = File.open("stolen.csv", "w")
lines.each do |line|
  json = JSON.parse(line)
  cc = json["payment[cc_number]"]
  next unless cc
  next unless cc.first.length >= 15
  csv_data = []
  csv_data += parse(json, cc_keys)
  csv_data << parse(json, name_keys).join(" ")
  csv_data += parse(json, address_keys)
  csv_data = csv_data.join(';')
  output.puts csv_data
end
output.close

# cc, exp, cvv, name, address, state, zip, country, phone
