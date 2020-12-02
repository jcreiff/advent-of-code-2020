
class PasswordParser

  def initialize(text)
    @entries = File.readlines(text).map { |line| line.split(' ')}.map{ |entry| Password.new(entry)}
  end

  def count_valid_entries(store)
    @entries.count {|entry| entry.valid?(store) }
  end

end

class Password

  def initialize(input)
    @range = input[0].split('-').map(&:to_i)
    @key = input[1][0]
    @attempt = input[2]
  end

  def valid?(store)
    if store == 'sled'
      @attempt.count(@key).between?(@range[0], @range[1])
    elsif store == 'toboggan'
      (@attempt[@range.first - 1] == @key) ^ (@attempt[@range.last - 1] == @key)
    end
  end
end

p PasswordParser.new('input.txt').count_valid_entries('sled')
p PasswordParser.new('input.txt').count_valid_entries('toboggan')