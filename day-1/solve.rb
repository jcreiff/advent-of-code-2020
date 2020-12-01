entries = File.readlines('input.txt').map(&:to_i)

def find_2020_product(list, n)
  list.combination(n).find{ |combo| combo.sum==2020 }.reduce(:*)
end

p find_2020_product(entries, 2)
p find_2020_product(entries, 3)