class Way

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

  def find_way

    # Clean up.
    reset_visiting_state

    # Enqueue start position.
    @queue = []
    enqueue_cell([], @start_x, @start_y)
    puts "start x = #{@start_x}, start y= #{@start_y}"
    # Loop as long as there are cells to visit and no solution has
    # been found yet.
    path = nil
    until path || @queue.empty?
      path = solve_visit_cell
    end

    if path
      # Mark the cells that make up the shortest path.
      for x, y in path
        @path[x][y] = true
      end
    else
      puts "No solution found?!"
    end
  end

  private

  # Maze solving visiting method.
  def solve_visit_cell
    # Get the next path.
    path = @queue.shift
    # The cell to visit is the last entry in the path.
    x, y = path.last

    # Have we reached the end yet?
    return path  if x == @end_x && y == @end_y

    # Mark cell as visited.
    @visited[x][y] = true

    for dx, dy in DIRECTIONS
      if dx.nonzero?
        # EAST / WEST
        new_x = x + dx
        if move_valid?(new_x, y) && !@vertical_walls[ [x, new_x].min ][y]
          if dx == 1
            puts "WEST"
          else puts "EAST"
          end
          enqueue_cell(path, new_x, y)
        end
      else
        # NORTH / SOUTH
        new_y = y + dy
        if move_valid?(x, new_y) && !@horizontal_walls[x][ [y, new_y].min ]
          if dy == 1
            puts "SOUTH"
          else puts "NORTH"
          end
          enqueue_cell(path, x, new_y)
        end
      end
    end

    nil         # No solution yet.
  end

  # Enqueue a new coordinate to visit.
  def enqueue_cell(path, x, y)
    # Add new coordinates to the current path and enqueue the new path.
    @queue << path + [[x, y]]
  end
end