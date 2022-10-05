require_relative "player"
require "byebug"

class Game
    attr_reader :players, :current_player, :bonus

    def initialize(*names)
        @players = []
        names.each do |name|
            player = Player.new(name)
            @players << player
        end
        @current_player = @players[0]
        @bonus = 5
    end

    def print_game_state
        system("clear")
        p "#{current_player.name}'s turn.  Here are his points so far:"
        p current_player.score
        p "These are the options avaliable:"
        p current_player.available
    end

    def get_choice
        choice = gets.chomp
        until current_player.available.include?(choice)
            p 'Please enter a valid choice.'
            choice = gets.chomp
        end
        choice
    end

    def switch_players!
        @players = @players[1..-1] + [@current_player]
        @current_player = @players[0]
    end

    def turn
        print_game_state
        indices = [0,1,2,3,4]
        hand = Hand.new
        while hand.rolls < 3
            hand.rolls += 1
            hand.roll(indices)
            hand.print
            if hand.rolls != 3
                p 'Do you want to roll again?'
                response = gets.chomp
            end
            if response == 'n' || hand.rolls == 3
                hand.rolls = 3
            else
                p 'choose which dice to reroll, with indices separated by a space'
                choice = gets.chomp.split(' ')
                indices = []
                choice.each {|ele| indices << ele.to_i}
            end
        end
        p @current_player.score
        p "#{current_player.name}, choose how to score your roll"
        choice = get_choice
        score(current_player,hand,choice)
        p current_player.score
        switch_players!
    end
    
    def score(player,hand,choice)
        nums = ['uno', 'dos', 'tres', 'cuatro', 'cinco', 'seis']
        if nums.include?(choice)
            score_num(player,hand,choice)
        elsif choice == 'escalera'
            score_escalera(player,hand,choice)
        elsif choice == 'full'
            score_full(player,hand,choice)
        elsif choice == 'poker'
            score_poker(player,hand,choice)
        else
            score_generala(player,hand,choice)
        end
        player.available.reject! {|ele| ele == choice}
        true
    end

    def score_num(player,hand,choice)
        nums = {'uno' => 1, 'dos' => 2, 'tres' => 3, 'cuatro' => 4, 'cinco' => 5, 'seis' => 6}
        points = nums[choice] * hand.count_nums[nums[choice]]
        player.score[choice] = points
    end

    def score_escalera(player,hand,choice)
        if hand.sorted == [1,2,3,4,5] || hand.sorted == [2,3,4,5,6]
            player.score['escalera'] = 20
            player.score['escalera'] += bonus if hand.rolls == 1
        else
            player.score['escalera'] = 0
        end
    end

    def score_full(player,hand,choice)
        hand_count = hand.count_nums
        if hand_count.has_value?(2) && hand_count.has_value?(3)
            player.score['full'] = 30
            player.score['full'] += bonus if hand.rolls == 1
        else
            player.score['full'] = 0
        end
    end

    def score_poker(player,hand,choice)
        hand_count = hand.count_nums
        if hand_count.has_value?(4)
            player.score['poker'] = 40
            player.score['poker'] += @bonus if hand.rolls == 1
        else
            player.score['poker'] = 0
        end
    end

    def score_generala(player,hand,choice)
        hand_count = hand.count_nums
        if hand_count.has_value?(5)
            if hand.rolls == 1
                p player.name + " wins the game!"
                return
            end
            player.score['generala'] = 50
        else
            player.score['generala'] = 0
        end
    end

    def done?
        @players.all? {|player| player.available == []}
    end

    def play
        until done?
            turn
        end
        players.each do |player|
            total_score = 0
            player.score.each_value {|v| total_score += v}
            p "#{player.name} tiene #{total_score.to_s} puntos!"
        end
    end

end


game = Game.new("Daniel","Pia")
game.play