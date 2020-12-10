set = File.readlines('input.txt').map(&:to_i)

sum = set.each_cons(26).find { |group| group[0, 25].combination(2).none? {|pair| pair.sum == group[-1]}}.last

def find_weakness(list, n, target)
  list.each_cons(n).find{ |group| group.sum == target }
end

size = 2
until find_weakness(set, size, sum)
  size += 1
end

weakness = find_weakness(set, size, sum)
p weakness.max + weakness.min