entries = File.readlines('input.txt').map(&:strip)

terrain = (0..entries.count-1).to_a.zip(entries)

def tree_count(rows, right, down)
  tree_count = 0
  index = right
  rows.each do |row, col|
    next if row.zero? || row % down != 0
    tree_count += 1 if col[index % 31]=='#'
    index+=right
  end
  tree_count
end

p tree_count(terrain, 3, 1)

p [[1,1], [3,1], [5,1], [7,1], [1,2]].map {|x, y| tree_count(terrain, x, y)}.reduce(:*)