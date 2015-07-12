require '../Labirint/map'
require '../Labirint/way'
class Dron


  def initialize(width, height)
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
    @path = Array.new(width) { Array.new(height) }

    # "Hack" to print the exit.
    @horizontal_walls[@end_x][@end_y] = false

  end

end

# Demonstration:
#dron = Dron.new 10,10
#dron.solve
#dron.print
dron = Map.new(10,10)
dron.print
dron = Way.new(10,10)
dron.find_way


