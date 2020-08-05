require 'pry'
class Node
  include Comparable
  attr_accessor :data, :left_child, :right_child

  def initialize(data)
    @data = data
    @left_child = nil
    @right_child = nil
  end

  def <=>(other_node)
    @data <=> other_node.data
  end
end

class Tree
  attr_accessor :root, :ary
  def initialize(ary)
    @ary = ary.sort.uniq
    @root = build_tree(@ary)
  end

  def build_tree(ary)
    return nil if ary.empty?
    return Node.new(ary[0]) if ary.length == 1
    midpoint = ary.length / 2
    parent = Node.new(ary[midpoint])
    parent.left_child = ary[0..midpoint - 1]
    parent.right_child = ary[midpoint + 1..ary.length]
    p parent
    build_tree(parent.left_child)
    build_tree(parent.right_child)
    parent
  end
end

test = [1, 2, 4, 7, 4, 13, 6, 8, 5, 66]

p Tree.new(test)