class Node
  attr_accessor :coord, :parent

  def initialize(coord, parent = nil)
    @coord = coord
    @parent = parent
  end
end

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
      next unless on_board?(pos_move) #makes a node for every possible legal move from a given location

      @positions << Node.new(pos_move.dup, @current)
    end
  end

  def check_for_match(ary = @positions)
    ary.each do |node|
      next unless target.eql?(node.coord) #if the node is at the target location, print route and break

      print_route(node)
      @target_reached = true
      break
    end
  end

  def move_again(ary = @positions.dup)
    @positions = [] #empties array to avoid passing old nodes through check_for_match again
    ary.each do |node| #have move_knight create nodes at the possible \n
                           #move locations of each current possible location
      @current = node
      move_knight
    end
  end

  def print_route(node, ary = [])
    until node.nil?  #pushes the route history of node
      ary << node.coord
      node = node.parent
    end
    ary.reverse!
    (0..ary.length - 2).each do |i|
      print "#{ary[i]} --> "
    end
    print "#{ary[-1]}\n"
  end

  def on_board?(coord = @coord)
    coord.each do |value|
      return false if value > 8 || value < 1 #creates a virtual 8x8 board
    end
    true
  end

  def find_route
    until @target_reached == true
      move_knight
      check_for_match
      move_again
    end
  end
end

test = Knight.new([1,1], [8,8])
test.find_route