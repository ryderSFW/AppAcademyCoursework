require_relative 'tile'

class Board
    def initialize
        @grid = self.gen_empty_grid
        p @grid
    end
    def gen_empty_grid
        Array.new(9) {Array.new(9) {Tile.new}} 
    end
    def render
        puts "   #{(0..@grid.length-1).to_a.join(" ")}"
        @grid.each_with_index do |row, i|
            if i < 10 
                puts "#{i}  #{row.join(" ")}"
            else
                puts "#{i} #{row.join(" ")}"
            end
        end
    end
    def place_bombs
        #decide how many bombs to place, then generate that num of random posiitions on the board, put bombs there
        15.times do 
            pos = get_rand_unassigned_pos
            self[pos].set_bomb
        end 
    end
    def [](pos)
        row, ele = pos[0], pos[1]
        @grid[row][ele]
    end
    def []=(pos, val)
        row, ele = pos[0], pos[1]
        @grid[row][ele] = val
    end
    def get_rand_unassigned_pos
        pos = [rand(8), rand(8)]
        if self[pos].bomb
            return get_rand_unassigned_pos
        else
            pos
        end
    end
    def reveal_all_bombs
        @grid.each do |row|
            row.each do |tile|
                tile.reveal if tile.bomb
            end
        end
    end
end

if __FILE__ == $PROGRAM_NAME
    board = Board.new
    board.render
    # p board[[0,0]]
    # board[[0,0]] = "X"
    # board.render
    board.place_bombs
    board.reveal_all_bombs
    board.render
end