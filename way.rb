class Way

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

    generate
  end

  def find_way

    reset_visiting_state

    @queue = []
    enqueue_cell([], @start_x, @start_y)
    puts "start x = #{@start_x}, start y= #{@start_y}"

    path = nil
    until path || @queue.empty?
      path = solve_visit_cell
    end

    if path
      for x, y in path
        @path[x][y] = true
      end
    else
      puts "No solution found?!"
    end
  end

  private

  def solve_visit_cell

    path = @queue.shift

    x, y = path.last


    return path  if x == @end_x && y == @end_y


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


  def enqueue_cell(path, x, y)

    @queue << path + [[x, y]]
  end
end