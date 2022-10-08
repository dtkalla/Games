require_relative "board"

class Game

    def initialize(player_1_name,player_2_name,num_pieces = 4)
        @player1 = Player.new(player_1_name,:white)
        @player2 = Player.new(player_2_name,:blue)
        @board = Board.new(num_pieces)
        @current_player = @player1
    end

    def switch_turns!
        @current_player == @player1 ? @current_player = @player2 : @current_player = @player1
    end

    def placement_turn

    end

end