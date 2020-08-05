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
    left = ary[0..midpoint - 1]
    right = ary[midpoint + 1..ary.length]
    parent.left_child = build_tree(left)
    parent.right_child = build_tree(right)
    parent
  end

  def insert(value, root = @root)
    new_node = Node.new(value)
    if new_node < root
      if root.left_child.nil?
        root.left_child = new_node 
      else
        insert(value, root.left_child)
      end
    elsif new_node > root
      if root.right_child.nil?
        root.right_child = new_node
      else
        insert(value, root.right_child)
      end
    end
  end
end

test = [1, 2, 4, 7, 4, 3]

original = Tree.new(test)
p original
puts
new = original.insert(6)

p new
puts
p original

