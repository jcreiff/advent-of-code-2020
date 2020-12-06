p File.read('input.txt').split("\n\n").map{ |group| group.gsub("\n", "").chars.uniq.count }.sum
