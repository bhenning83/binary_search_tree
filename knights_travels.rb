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
  attr_accessor :current, :target, :positions

  def initialize(current, target)
    @current = Node.new(current)
    @target = target
    @moves = [[-1, 2], [-1, -2], [-2, -1], [-2, 1], [1, 2], [1, -2], [2, 1], [2, -1]]
    @target_reached = false
    @positions = []
  end

  def move_knight(current = @current.coord, pos_move = [])
    @moves.each do |move|
      current.each_index do |i|
         pos_move[i] = current[i] + move[i]
        end
      next if !on_board?(pos_move)
      new_spot = Node.new(pos_move.dup, @current) 
      @positions << new_spot
    end
  end

  def check_for_match(ary = @positions)
    ary.each do |node|
      if target.eql?(node.coord)
        print_route(node)
        @target_reached = true
      end
    end
  end
  
  def move_again(ary = @positions.dup)
    @positions = []
    ary.each do |node|
      @current = node
      move_knight
    end
  end

  def print_route(node, ary = [])
    until node.nil?
      ary << node.coord 
      node = node.parent
    end
    ary.reverse!
    for i in 0..ary.length - 2
      print "#{ary[i]} --> "
    end
    print "#{ary[-1]}\n"
  end

  def on_board?(coord = @coord)
    coord.each do |value|
      return false if value > 8 || value < 1
    end
    true
  end

  def find_route
    until @target_reached == true do 
      move_knight
      check_for_match
      move_again
    end
  end
end

class Node
  attr_accessor :coord, :parent

  def initialize(coord, parent = nil)
    @coord = coord
    @parent = parent
  end
end

test = Knight.new([1, 2], [8, 7])

test.find_route

