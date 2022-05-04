require_relative 'tile'

class Board
    def initialize(size)
        @grid = self.gen_empty_grid(size)
    end
    def gen_empty_grid(size)
        Array.new(size) {Array.new(size, Tile.new)}
    end
    def render
        puts "  #{(0..@grid.length - 1).to_a.join(" ")}"
        @grid.each_with_index do |row, i|
            puts "#{i} #{row.join(" ")}"
        end
    end
    def place_bombs
        #decide how many bombs to place, then generate that num of random posiitions on the board, put bombs there
    end
end

if __FILE__ == $PROGRAM_NAME
    board = Board.new(3)
    board.render

end