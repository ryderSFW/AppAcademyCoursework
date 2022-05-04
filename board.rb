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
    def reveal_pos(pos)
        self[pos].reveal
    end
    def get_neighbors(pos)
        #returns the positions of all neighbors of pos
        #returns as array of pos e.g. [[pos1], [pos2], [pos3]]
        neighbor_positions = []
        row, ele = pos[0], pos[1]
        #get the diagonal neighbors
        neighbor_positions << [row - 1, ele - 1] if row > 0 && ele > 0
        neighbor_positions << [row - 1, ele + 1] if row > 0 && ele < 8
        neighbor_positions << [row + 1, ele + 1] if row < 8 && ele < 8
        neighbor_positions << [row + 1, ele - 1] if row < 8 && ele > 0
        neighbor_positions << [row - 1, ele] if row > 0
        neighbor_positions << [row, ele + 1] if ele < 8
        neighbor_positions << [row + 1, ele] if row < 8
        neighbor_positions << [row, ele - 1] if ele > 0 
    end
    def gen_value(pos)
        #call count_bombs_neighbors(get_neighbors(pos))
        #set value of tile at pos to count of bombs
    end
    def count_bombs_neighbors(array_of_positions)
        #return num of bomb tiles in array_of_pos
    end
    def reveal_neighbors(pos)
        #reveals all neighboring tiles of pos
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
    board.get_neighbors([0, 0]) #1,1  0,1  1,0  
    board.get_neighbors([4, 4]) #3,3  3,5  5,5  5,3  3,4  4,5  5,4  4,3
    board.get_neighbors([8, 8]) #7,7  7,8  8,7
    board.get_neighbors([8, 0]) #7,1  7,0  8,1
    board.get_neighbors([0, 8]) #1,7  1,8  0,7
    board.get_neighbors([8, 4]) #7,3  7,5  7,4  8,5  8,3  
    board.get_neighbors([5, 0]) #4,1  6,1  4,0  5,1  6,0
    board.get_neighbors([3, 8]) #2,7  4,7  2,8  4,8, 3,7
    board.get_neighbors([0, 3]) #1,4  1,2  0,4  1,3  0,2
end