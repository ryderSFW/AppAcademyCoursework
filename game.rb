require_relative 'board'
require 'yaml'
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
        return input[0] if input[0] == "save" || input[0] == "load"
        input[0] == 'flag' ? ['flag', input[1].to_i, input[2].to_i] : [input[0].to_i, input[1].to_i]
    end
    def make_move(input)
        input[0] == 'flag' ? @board.flag_unflag([input[1], input[2]]) : @board.reveal_pos([input[0], input[1]])
    end
    def play
        # #cheat for testing
        # @board.reveal_bombs
        if !@game_over
            input = get_move
            make_move(input) unless input == 'save' || input == 'load'
        end
        while !@game_over
            if input == "save"
                puts "Saving the game and exiting..."
                save_game
                break
            end
            if input == "load"
                load_game
                break
            end
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
                make_move(input) unless input == 'save' || input == 'load'
            end
        end
    end
    def save_game
        File.open("saved_game.yaml", "w") {|file| file.write(self.to_yaml)}
    end
    def load_game
        game = Psych.unsafe_load(File.read("saved_game.yaml"))
        game.play
    end
end

if __FILE__ == $PROGRAM_NAME
    game = Game.new
    game.play

end