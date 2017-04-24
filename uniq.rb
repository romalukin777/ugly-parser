lines = File.readlines("stolen.csv").map(&:strip)
data = {}
lines.each do |line|
  cc_num = line[0...15]
  data[cc_num] = line
end
out = File.open("stolen-2.csv", "w")
data.each do |num, line|
  out.puts line
end
out.close
