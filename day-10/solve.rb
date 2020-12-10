joltages = File.readlines('input.txt').map(&:to_i).sort

p joltages.each_cons(2).map { |a, b| b - a }.partition {|a| a==1}.map {|group| group.count + 1 }.reduce(&:*)