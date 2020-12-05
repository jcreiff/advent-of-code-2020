class BoardingPass
  attr_reader :seat_id
  BINARY_SUB = { 'F' => 0, 'B' => 1, 'L' => 0, 'R' => 1 }
  
  def initialize(input)
    @row = decode(input[0..6])
    @seat = decode(input[7..9])
    @seat_id = @row * 8 + @seat
  end

  private

  def decode(input)
    input.chars.map{ |c| BINARY_SUB[c] }.join.to_i(2)
  end
end

passes = File.readlines('input.txt').map {|pass| BoardingPass.new(pass)}
seat_ids = passes.map(&:seat_id)

max = seat_ids.max
min = seat_ids.min
missing = (min..max).to_a - seat_ids
