class BagMaker
  def self.make_bags(input)
    colors = File.readlines(input).map {|bag| bag.scan(/(\w+\s\w+)\sbag/).flatten }
    colors.each { |bag| Bag.new(bag[0], bag[1..-1])}
    Bag.all.map { |bag| bag.contents.each { |c| Bag.find(c) << bag.color }} 
  end
end

class Bag
  @@collection = {}
  attr_reader :color, :contents, :contained_by

  def initialize(color, contents)
    @color = color
    @contents = contents.reject {|color| color == "no other" }
    @contained_by = []
    @@collection[@color] = self
  end

  def self.all
    @@collection.values
  end

  def self.find(color)
    @@collection[color]
  end

  def <<(other)
    @contained_by.push(other)
  end

  def up_the_chain(next_level = nil, containers = [])
    next_level ||= Bag.all.select { |bag| bag.contents.include?(color)}
    return containers.count if next_level.all? { |level| containers.include?(level) }
    containers << next_level
    next_level = next_level.map { |bag| bag.contained_by }.flatten.map { |c| Bag.find(c) }
    up_the_chain(next_level, containers.flatten.uniq)
  end

end

BagMaker.make_bags('input.txt')
p Bag.find('shiny gold').up_the_chain