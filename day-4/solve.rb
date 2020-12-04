REQUIRED = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]
entries = File.readlines('input.txt').join.split("\n\n").map(&:split)
parsed = entries.map{|entry| entry.map{|string| string.split(":")}}

p parsed.map { |entry| entry.transpose}.count {|passport| REQUIRED.all? {|field| passport.first.include?(field)}}

