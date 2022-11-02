require 'ruby2d'
require_relative './lib/grid'

set background: 'black'

SQUARE_SIZE = 30
set width: SQUARE_SIZE * 20
set height: SQUARE_SIZE * 20
=begin
class Grid
  def initialize
    @grid = {}
    @playing = false
  end

  def clear
    @grid = {}
  end

  def play_pause
    @playing = !@playing
  end

  def draw_lines
    (Window.width / SQUARE_SIZE).times do |x|
    Line.new(
    width: 1,
    color: 'green',
    y1: 0,
    y2: Window.height,
    x1: x * SQUARE_SIZE,
    x2: x * SQUARE_SIZE
    )

    (Window.height / SQUARE_SIZE).times do |y|
      Line.new(
        width: 1,
        color: 'green',
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
                color: 'green',
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
=end
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
    if event.key == 'space'
        grid.play_pause
    end
    if event.key == 'c'
      grid.clear
    end
end

show