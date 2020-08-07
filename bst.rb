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
    @ary = ary
    @root = build_tree(@ary)
    @parent = nil
  end

  def build_tree(ary)
    ary = ary.uniq.sort
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
    @ary << new_node.data
    if new_node < root
      return root.left_child = new_node if root.left_child.nil?
      insert(value, root.left_child)
    elsif new_node > root
      return root.right_child = new_node if root.right_child.nil?
      insert(value, root.right_child)
    end
  end

  def delete(value, root = @root)
    root = find(value)
    root.data = nil if root.left_child.nil? && root.right_child.nil?
    if root.left_child.nil?
      @parent.right_child = root.right_child
    elsif root.right_child.nil?
      @parent.left_child = root.left_child
    else
      next_biggest = find_next_biggest(root)
      temp_node = next_biggest.dup
      delete(next_biggest.data)
      root.data = temp_node.data
    end
  end
  
  def find(value, root = @root)
    return 'value not included' if root.data.nil?
    return root if root.data == value
    if value < root.data
      @parent = root
      find(value, root = root.left_child)
    else
      @parent = root
      find(value, root = root.right_child)
    end
  end

  def find_next_biggest(root)
    next_level = root.right_child
    until next_level.nil?
      next_biggest = next_level
      next_level = next_level.left_child
    end
    next_biggest
  end

  def level_order(root = @root, output = [], queue = [])
    return output if root.nil?
    output << root.data
    queue << root.left_child unless root.left_child.nil?
    queue << root.right_child unless root.right_child.nil?
    root = queue.shift
    level_order(root, output, queue)
  end

  def inorder(root = @root, output = [])
    return if root.nil?
    inorder(root.left_child, output)
    output << root.data
    inorder(root.right_child, output)
    output
  end

  def preorder(root = @root, output = [])
    return if root.nil?
    output << root.data
    preorder(root.left_child, output)
    preorder(root.right_child, output)
    output
  end

  def postorder(root = @root, output = [])
    return if root.nil?
    postorder(root.left_child, output)
    postorder(root.right_child, output)
    output << root.data
    output
  end

  def height(root = @root, counter = 0, ary = [])
    return ary.max if root.nil?
    ary << counter
    counter += 1
    height(root.left_child, counter, ary)
    height(root.right_child, counter, ary)
  end

  def balanced?(root = @root)
    left = height(root.left_child)
    right = height(root.right_child)
    return true if (left - right).abs <=1
    return false
  end

  def rebalance(tree)
    level = level_order(tree)
    @root = build_tree(level)
  end
end

test = [1, 2, 4, 7, 4, 3, 5, 8, 10]

array = Array.new(15) { rand(1..100) }
tree = Tree.new(array)
p tree.balanced?
p tree.level_order
p tree.preorder
p tree.postorder
p tree.inorder
tree.insert(199)
tree.insert(197)
tree.insert(196)
tree.insert(195)
tree.insert(194)
tree.insert(198)
p tree.balanced?
tree.rebalance(tree.root)
p tree.balanced?
p tree.level_order
p tree.preorder
p tree.postorder
p tree.inorder
