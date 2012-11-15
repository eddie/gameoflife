#!/usr/bin/ruby

# Conways Game of Life 
# eddie.b eblundell@gmail.com

class Grid
  
  def initialize(rows,cols)
    @rows = rows
    @cols = cols
    @grid = Array.new(@rows) { Array.new(@cols) }
    @next_grid = Array.new(@rows){ Array.new(@cols)}
  end

  # Simple grid traveler
  def travel_grid()
    (0...@rows).each { |x| (0...@cols).each { |y| yield x,y } }
  end

  # Randomly seeds the grid
  def seed    
    travel_grid { |x,y| @next_grid[x][y]=(rand(2)==1)?true:nil}
  end

  # Displays the grid
  def display     
    
    (0...@rows).each do |x|
      (0...@cols).each do |y|
        if @next_grid[x][y]
          print ' x '
        else
          print '   '
        end
        @grid[x][y] = @next_grid[x][y]
      end
      puts
    end

  end

  def cell_alive?(x,y)
    begin
      return @grid[x][y] ? 1:0
    rescue
      return 0
    end
  end
  
  def count_live_neighbours(x,y)
    cell_alive?(x+1,  y) + cell_alive?(x-1,y  ) + cell_alive?(x  ,y-1) + cell_alive?(x  ,y+1) + 
    cell_alive?(x-1,y-1) + cell_alive?(x+1,y+1) + cell_alive?(x-1,y+1) + cell_alive?(x+1,y-1)
  end

  def create_at!(x,y) @next_grid[x][y]=true end

  def step

    travel_grid do |x,y|
         
      # count the neighbours for the cell
      neighbours = count_live_neighbours(x,y)

      # the cell is alive
      if @grid[x][y]
        if neighbours > 3 or neighbours < 2 
          @next_grid[x][y] = nil
        end
        if neighbours == 3
          @next_grid[x][y]=true
        end
      # Cell is not alive
      elsif
        # It has three neighbours
        if neighbours == 3
          @next_grid[x][y] = true
        end
      end  

    end
    
  end
  
  
end



g = Grid.new(40,32)
g.seed

1000.times { |x|
  system('clear')
  g.display
  g.step
  puts 'Cycle:',x
  sleep(1.0/8.0)
}





