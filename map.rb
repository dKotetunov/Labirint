require '../Labirint/way'
class Map

  def initialize(width,height)
    @width   = width
    @height  = height
    @start_x = rand(width)
    @start_y = 0
    @end_x   = rand(width)
    @end_y   = height - 1

    # Which walls do exist? Default to "true". Both arrays are
    # one element bigger than they need to be. For example, the
    # @vertical_walls[x][y] is true if there is a wall between
    # (x,y) and (x+1,y). The additional entry makes printing easier.
    @vertical_walls   = Array.new(width) { Array.new(height, true) }
    @horizontal_walls = Array.new(width) { Array.new(height, true) }
    # Path for the solved maze.
    @path             = Array.new(width) { Array.new(height) }

    # "Hack" to print the exit.
    @horizontal_walls[@end_x][@end_y] = false

  end

  # Print a nice ASCII maze.
  def print
    # Special handling: print the top line.
    puts @width.times.inject("+") {|str, x| str << (x == @start_x ? "   +" : "---+")}

    # For each cell, print the right and bottom wall, if it exists.
    @height.times do |y|
      line = @width.times.inject("|") do |str, x|
        str << (@path[x][y] ? " * " : "   ") << (@vertical_walls[x][y] ? "|" : " ")
      end
      puts line

      puts @width.times.inject("+") {|str, x| str << (@horizontal_walls[x][y] ? "---+" : "   +")}
    end
  end

  private
  # Generate the maze.
  def generate
    reset_visiting_state
    generate_visit_cell(@start_x, @start_y)
  end

end