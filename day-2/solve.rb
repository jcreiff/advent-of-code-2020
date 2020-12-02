
class PasswordParser

  def initialize(text)
    @entries = File.readlines(text).map { |line| line.split(' ')}
  end

  def count_valid_entries
    @entries.count {|entry| valid?(entry) }
  end

  private

  def valid?(entry)
    range = entry[0].split('-').map(&:to_i)
    key = entry[1][0]
    instances = entry[2].count(key)
    instances.between?(range[0], range[1])
  end
end

p PasswordParser.new('input.txt').count_valid_entries