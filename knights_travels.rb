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

class Knight
  attr_accessor :current, :target

  def initialize(current, target)
    @current = current
    @target = target
  end

  def on_board?(coord = @coord)
    coord.each do |value|
      return false if value > 8 || value < 1
    end
    true
  end
end

class Node
  def initialize(coord, parent)
    @coord = coord
    @parent = parent
  end
end

test = Knight.new([3, 4], [6, 7])



