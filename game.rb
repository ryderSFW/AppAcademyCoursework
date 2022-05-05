require_relative 'board'

class Game
    def initialize(board = Board.new)
        @board = board
        @game_over = false
    end
    def get_move
        @board.render
        puts "Enter your next move as: row,column to reveal"
        puts "flag,row,column to place or remove flag"
        input = gets.chomp.split(",")
        input[0] == 'flag' ? ['flag', input[1].to_i, input[2].to_i] : [input[0].to_i, input[1].to_i]
    end
    def make_move(input)
        input[0] == 'flag' ? @board.flag_unflag([input[1], input[2]]) : @board.reveal_pos([input[0], input[1]])
    end
    def play
        #cheat for testing
        @board.reveal_bombs
        input = get_move
        make_move(input)
        while !@game_over
            if input.length == 2 && @board[input].bomb && !@board[input].flagged
                puts "You Died!"
                @board.reveal_bombs
                @game_over = true
                @board.render
            elsif @board.won?
                puts "You Won!"
                @game_over = true
                @board.render
            else
                input = get_move
                make_move(input)
            end
        end
    end
end

if __FILE__ == $PROGRAM_NAME
    game = Game.new
    game.play
end