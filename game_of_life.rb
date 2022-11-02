require 'ruby2d'

set background: 'white'

SQUARE_SIZE = 40
set width: SQUARE_SIZE * 16
set height: SQUARE_SIZE * 12

class Grid
  def initialize
    @grid = {}
    @playing = false
  end
  def play_pause
    @playing = !@playing
  end

  def draw_lines
    (Window.width / SQUARE_SIZE).times do |x|
    Line.new(
    width: 1,
    color: 'gray',
    y1: 0,
    y2: Window.height,
    x1: x * SQUARE_SIZE,
    x2: x * SQUARE_SIZE
    )

    (Window.height / SQUARE_SIZE).times do |y|
      Line.new(
        width: 1,
        color: 'gray',
        x1: 0,
        x2: Window.width,
        y1: y * SQUARE_SIZE,
        y2: y * SQUARE_SIZE
        )
      end
    end
   
    def toggle(x,y)
      if @grid.key?([x, y])
        @grid.delete([x, y])
      else
        @grid[[x, y]] = true
      end
     
    end
    
    def draw_alive_squares
        @grid.keys.each do |x, y|
            Square.new(
                color: 'black',
                x: x * SQUARE_SIZE,
                y: y * SQUARE_SIZE,
                size: SQUARE_SIZE
            )
        end
    end
    def advance_frame
        if @playing
          new_grid = {}

          (Window.width / SQUARE_SIZE).times do |x|
            (Window.height / SQUARE_SIZE).times do |y|
              alive = @grid.key?([x, y])

              alive_neighbours = [
                # NW
                @grid.key?([x - 1, y - 1]),
                # N
                @grid.key?([x, y - 1]),
                # NE
                @grid.key?([x + 1, y - 1]),
                # E
                @grid.key?([x + 1, y]),
                # SE
                @grid.key?([x + 1, y + 1]),
                # S
                @grid.key?([x, y + 1]),
                # SW
                @grid.key?([x - 1, y + 1]),
                # W
                @grid.key?([x - 1, y ])
              ].count(true)

              if (alive && alive_neighbours.between?(2,3)) || (!alive && alive_neighbours == 3)
                new_grid[[x,y]] = true
              end

            end
          end
          @grid = new_grid  
        end
    end
  end
end

grid = Grid.new

update do
    clear
    grid.draw_lines
    grid.draw_alive_squares

    if (Window.frames % 20).zero?
        grid.advance_frame
    end
end

on :mouse_down do |event|
    grid.toggle(event.x / SQUARE_SIZE, event.y / SQUARE_SIZE)
end

on :key_down do |event|
    if event.key == 'p'
        grid.play_pause
    end
end

show