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
    all_fields? && valid_data?
  end

  def all_fields?
    REQUIRED.all? { |field| @data.keys.include?(field) } 
  end
  
  def valid_data?
    @data.all? { |k, v| satisfy_rules?(k, v) }
  end

  private

  def satisfy_rules?(key, value)
    case key
    when 'byr'
      value.to_i.between?(1920, 2002)
    when 'iyr'
      value.to_i.between?(2010, 2020)
    when 'eyr'
      value.to_i.between?(2020, 2030)
    when 'hgt'
      value =~ /(\d+)(\D+)/ ? check_height($1.to_i, $2) : false
    when 'hcl'
      value =~ /\A[#][a-f0-9]{6}\z/
    when 'ecl'
      %w(amb blu brn gry grn hzl oth).include?(value)
    when 'pid'
      value =~ /\A\d{9}\z/
    else
      true
    end
  end

  def check_height(num, unit)
    num.between?(59, 76) && unit=="in" || num.between?(150, 193) && unit=="cm"
  end
end

# solves first puzzle
p PassportParser.parse('input.txt').map {|entry| Passport.new(entry)}.count(&:all_fields?)

# solves second puzzle
p PassportParser.parse('input.txt').map {|entry| Passport.new(entry)}.count(&:valid?)