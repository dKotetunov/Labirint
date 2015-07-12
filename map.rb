class Map

  DIRECTIONS = [ [1, 0], [-1, 0], [0, 1], [0, -1] ]
  #DIRECTIONS = { east: [1, 0], west: [-1, 0], north: [0, 1], south: [0, -1]}

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
    @path             = Array.new(width) { Array.new(height) }

    # "Hack" to print the exit.
    @horizontal_walls[@end_x][@end_y] = false

    # Generate the maze.
    generate
  end


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

  # Reset the VISITED state of all cells.
  def reset_visiting_state
    @visited = Array.new(@width) { Array.new(@height) }
  end

  # Is the given coordinate valid and the cell not yet visited?
  def move_valid?(x, y)
    (0...@width).cover?(x) && (0...@height).cover?(y) && !@visited[x][y]
  end

  
  def generate
    reset_visiting_state
    generate_visit_cell(@start_x, @start_y)
  end


  def generate_visit_cell(x, y)

    @visited[x][y] = true

    coordinates = DIRECTIONS.shuffle.map { |dx, dy| [x + dx, y + dy] }

    for new_x, new_y in coordinates
      next unless move_valid?(new_x, new_y)

      connect_cells(x, y, new_x, new_y)
      generate_visit_cell(new_x, new_y)
    end
  end


  def connect_cells(x1, y1, x2, y2)
    if x1 == x2

      @horizontal_walls[x1][ [y1, y2].min ] = false
    else

      @vertical_walls[ [x1, x2].min ][y1] = false
    end
  end


end