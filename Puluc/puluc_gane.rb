class PulucGame

    def initialize(player_1,player_2)
        @board = Board.new
        @player_1 = player_1
        @player_2 = player_2
        @current_player = player_1
    end

    def switch_players!
        @current_player == @player_1 ? @current_player = @player_2 : @current_player = @player_1
    end

end