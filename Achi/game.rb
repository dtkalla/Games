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
        @board.render
        puts "Please enter a position number to place your piece."
        pos = gets.chomp.to_i
        # until @board.empty?(pos)
        #     pos = gets.chomp.to_i
        # end
        @board.place_piece(@current_player,pos)
        switch_turns!
    end

    def play_game
        8.times {placement_turn}
        until board.game_over?
            take_turn
        end
        switch_turns!
        @board.render
        puts "#{@current_player.name} is the winner!"
    end

    def take_turn
        @board.render
        puts "These are the possible moves.  Please select the place to move your piece from."
        puts @board.possible_moves(@current_player.color)
        pos = gets.chomp.to_i
        @board.make_move(@current_player.color)
        switch_turns!
    end
end

game = Game.new("Daniel","Marion")
game.play_game
