# Create a new node class 
# create a new node somewhere on the board
# figure out all possible moves from that point
#   -check to see if move is still on the board
# create new nodes at all possible moves, connected back to the parent
# for each node
#   check to see if node is the target value
#   if not, repeat the process of finding all possible moves
#   break when target value is reached. 
# return the path of the nodes that found the value
require 'pry'
class Knight
  attr_accessor :current, :target

  def initialize(current, target)
    @current = Node.new(current)
    @target = target
    @moves = [[-1, 2], [-1, -2], [-2, -1], [-2, 1], [1, 2], [1, -2], [2, 1], [2, -1]]
  end

  def move_knight(current = @current.coord, pos_move = [])
    ary = []
    @moves.each do |move|
      current.each_index do |i|
         pos_move[i] = current[i] + move[i]
      end
      new_spot = Node.new(pos_move.dup, @current) if on_board?(pos_move)
      ary << new_spot
      match?(new_spot)
    end
  end

  def match?(node, queue = [])
    coord = node.coord
    if target.eql?(coord)
      queue << target
      node = node.parent
      until node.nil?
        queue << node.coord 
        node = node.parent
      end
      p queue.reverse
      exit!
    end
  end

  def on_board?(coord = @coord)
    coord.each do |value|
      return false if value > 8 || value < 1
    end
    true
  end

end

class Node
  attr_accessor :coord, :parent

  def initialize(coord, parent = nil)
    @coord = coord
    @parent = parent
  end
end

test = Knight.new([3, 4], [4, 2])

test.move_knight

