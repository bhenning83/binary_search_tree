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
      return root.left_child = new_node if root.left_child.nil?
      insert(value, root.left_child)
    elsif new_node > root
      return root.right_child = new_node if root.right_child.nil?
      insert(value, root.right_child)
    end
  end

  def delete(value, root = @root)
  end
  
  def find(value, root = @root)
    return 'not included' if root.data == nil
    return root if root.data == value
    if value < root.data
      find(value, root = root.left_child)
    else
      find(value, root = root.right_child)
    end
  end
end

test = [1, 2, 4, 7, 4, 3, 5, 8, 10]

original = Tree.new(test)
original.insert(6)
original.insert(83)
puts
p original
p original.find(6)
p original.find(83)