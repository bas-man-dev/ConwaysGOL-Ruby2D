require 'ruby2d'

set background: 'white'

SQUARE_SIZE = 40
set width: SQUARE_SIZE * 16
set height: SQUARE_SIZE * 12

class Grid
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
    end
end

grid = Grid.new

update do
    clear
    grid.draw_lines
end
show