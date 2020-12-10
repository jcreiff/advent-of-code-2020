class BagMaker
  def self.make_bags(input)
    raw = File.readlines(input)
    colors = raw.map {| bag| bag.scan(/(\w+\s\w+)\sbag/).flatten }
    numbers = raw.map { |bag| bag.scan(/(\d)/).flatten.map(&:to_i) }
    colors.zip(numbers).each { |bag| Bag.new(bag.first[0], bag.first[1..-1], bag.last)}
    Bag.all.map { |bag| bag.contents.each { |c| Bag.find(c) << bag.color }} 
  end
end

class Bag
  @@collection = {}
  attr_reader :color, :contents, :contained_by, :full_contents

  def initialize(color, contents, numbers)
    @color = color
    @contents = contents.reject {|color| color == "no other" }
    @full_contents = @contents.zip(numbers).map { |bag| Array.new(bag.last, bag.first) }.flatten
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

  def down_the_chain(next_level = nil, children = nil)
    children ||= full_contents
    next_level ||= full_contents.map { |c| Bag.find(c) }
    return children.flatten.count if next_level.empty? 
    children << next_level.map(&:full_contents)
    next_level = next_level.map(&:full_contents).flatten.map { |c| Bag.find(c) }
    down_the_chain(next_level, children)
  end
end

BagMaker.make_bags('input.txt')
Bag.find('shiny gold').up_the_chain
Bag.find('shiny gold').down_the_chain