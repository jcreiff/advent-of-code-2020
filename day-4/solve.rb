class PassportParser
  def self.parse(input)
    entries = File.readlines(input).join.split("\n\n").map(&:split)
    parsed = entries.map{|entry| entry.map{|string| string.split(":")}}
  end
end


class Passport
  REQUIRED = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]

  def initialize(input)
    @data = Hash[input]
  end

  def valid?
    REQUIRED.all? { |field| @data.keys.include?(field) }
  end
end

p PassportParser.parse('input.txt').map {|entry| Passport.new(entry)}.count(&:valid?)

