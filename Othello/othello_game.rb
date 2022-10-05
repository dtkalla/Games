require_relative "player"

class Othello
    attr_reader :board, :player_1, :player_2, :players, :current_player

    def initialize
        @player_1 = Player.new(:B)
        @player_2 = Player.new(:W)
        @board = Board.new
        @players = [@player_1,@player_2]
        @current_player = @player_1
    end

    def turn
        @board.print
        puts "Choose where to place a piece, with a space between the numbers"
        pos = gets.chomp.split(' ').map(&:to_i)
        while pos.length != 2 || !board.is_valid?(pos,@current_player.color)
            puts "Please enter a valid index."
            pos = gets.chomp.split(' ').map(&:to_i)
        end
        @board.place(pos,@current_player.color)
        @players = @players.rotate
        @current_player = @players[0]
        @board.print
        puts "Black has " + @board.score(player_1).to_s + " points."
        puts "White has " + @board.score(player_2).to_s + " points."
    end

    def play_othello
        while !@board.board_full?
            turn
        end
        if player_1.score > player_2.score
            puts "Player 1 wins!"
        elsif player_1.score < player_2.score
            puts "Player 2 wins!"
        else
            puts "It's a tie!"
        end
    end
end

game = Othello.new
game.play_othello
