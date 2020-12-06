groups = File.read('input.txt').split("\n\n")

unique_responses = groups.map{ |group| group.gsub("\n", "").chars.uniq.count }.sum

def find_common_chars(group)
  group.split.map(&:chars).reduce {|a, b| a & b }
end

common_responses = groups.map {|group| find_common_chars(group).count }.sum
