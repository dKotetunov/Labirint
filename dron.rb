require '../Labirint/way'
require '../Labirint/map'
class Dron

  DIRECTIONS = [ [1, 0], [-1, 0], [0, 1], [0, -1] ]
  #DIRECTIONS = { east: [1, 0], west: [-1, 0], north: [0, 1], south: [0, -1]}

  def initialize(width, height)
    @width   = width
    @height  = height
    @start_x = rand(width)
    @start_y = 0
    @end_x   = rand(width)
    @end_y   = height - 1

    @vertical_walls   = Array.new(width) { Array.new(height, true) }
    @horizontal_walls = Array.new(width) { Array.new(height, true) }

    @path             = Array.new(width) { Array.new(height) }

    @horizontal_walls[@end_x][@end_y] = false
  end
end

# Demonstration:
dron = Map.new 5,5
dron.find_way
dron.print