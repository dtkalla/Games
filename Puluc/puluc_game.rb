require_relative "board"
require_relative "player"

class PulucGame

    def initialize(player_1,player_2)
        @board = Board.new
        @player_1 = Player.new(player_1,:W)
        @player_2 = Player.new(player_2,:B)
        @current_player = @player_1
    end

    def switch_players!
        @current_player == @player_1 ? @current_player = @player_2 : @current_player = @player_1
        @board.change_turns
    end

    def turn
        puts "#{@current_player.name}'s turn"
        @board.print
        mov_num = @board.roll_dice
        color = @current_player.color
        puts "Write the index of the piece you want to move #{mov_num} spaces."
        move_index = gets.chomp.to_i
        while !@board.valid_move?(move_index,@current_player.color,mov_num)
            puts 'Please choose a valid move.'
            move_index = gets.chomp.to_i
        end
        @board.make_move(move_index,mov_num)
        switch_players!
    end

    def play_game
        while !@board.game_over?
            turn
        end
        switch_players!
        puts "#{@current_player.name} wins!"
    end
end

game = PulucGame.new('Daniel','Pia')
game.play_game