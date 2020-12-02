
class PasswordParser

  def initialize(text)
    @entries = File.readlines(text).map { |line| line.split(' ')}.map{ |entry| Password.new(entry)}
  end

  def count_valid_entries
    @entries.count {|entry| entry.valid? }
  end

end

class Password

  def initialize(input)
    @range = input[0].split('-').map(&:to_i)
    @key = input[1][0]
    @attempt = input[2]
  end

  def valid?
    @attempt.count(@key).between?(@range[0], @range[1])
  end
end

p PasswordParser.new('input.txt').count_valid_entries