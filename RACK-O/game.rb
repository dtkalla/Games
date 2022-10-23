require_relative "player"

class Game

    def initialize(player_1_name,player_2_name)
        @deck = Deck.new
        @discard_pile = [@deck.draw]
        @player_1 = Player.new(player_1_name,@deck)
        @player_2 = Player.new(player_2_name,@deck)
        @current_player = @player_1
        system("clear")
    end
    
    def game_over?
        @player_1.won? || @player_2.won?
    end

    def switch_players!
        @current_player == @player_1 ? @current_player = @player_2 : @current_player = @player_1
    end

    def play
        until game_over?
            new_card = get_card
            play_card(new_card)
            switch_players!
            @deck.populate if @deck.empty?
            system("clear")
        end
        switch_players!
        puts "#{@current_player.name} is the winner!  Congratulations!"
        puts "#{@player_1.name}'s hand:"
        @player_1.render
        puts "#{@player_2.name}'s hand:"
        @player_2.render
    end

    def get_card
        puts "Your turn, #{@current_player.name}"
        puts "The top card of the discard pile is #{@discard_pile[-1].number}."
        @current_player.render
        puts "Would you like to draw from the deck(1) or discard pile(2)?"
        choice = gets.chomp
        choice == "2" ? card = @discard_pile.pop : @deck.draw
    end

    def play_card(card)
        puts "Your card is #{card.number}."
        puts "Please enter the index of the card you'd like to replace (or anything else to discard)."
        choice = gets.chomp
        if valid_index?(choice)
            discard = @current_player.replace_card(choice.to_i,card)
            @discard_pile << discard
        else
            @discard_pile << card
        end        
    end

    def valid_index?(choice)
        nums = ['1','2','3','4','5','6','7','8','9','10']
        nums.include?(choice)
    end

end

game = Game.new("Daniel","Anne")
game.play