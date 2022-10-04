require_relative "hand.rb"
require_relative "player.rb"
require "byebug"

class Array



end

class Game
    attr_reader :players, :current_player

    def initialize(*names)
        @players = []
        names.each do |name|
            player = Player.new(name)
            @players << player
        end
        @current_player = @players[0]
    end

    def turn
        puts
        p current_player.name
        p current_player.score
        p current_player.available
        i = 0
        indices = [0,1,2,3,4]
        hand = Hand.new
        while i < 3
            i += 1
            hand.roll(indices)
            hand.print
            if i != 3
                p 'Do you want to roll again?'
                response = gets.chomp
            else
                response = 'n'
            end
            if response == 'n'
                p current_player.available
                p 'Choose how to score your roll'
                choice = gets.chomp
                while !current_player.available.include?(choice)
                    p 'Please enter a valid choice.'
                    choice = gets.chomp
                end
                score(current_player,hand,choice,i)
                p current_player.score
                @players = @players[1..-1]
                @players << current_player
                @current_player = @players[0]
                i = 3
            else
                p 'choose which dice to reroll, with indices separated by a space'
                choice = gets.chomp.split(' ')
                indices = []
                choice.each {|ele| indices << ele.to_i}
            end
        end
        true
    end
    
    def score(player,hand,choice,i)
        nums = {'uno' => 1, 'dos' => 2, 'tres' => 3, 'cuatro' => 4, 'cinco' => 5, 'seis' => 6}
        if nums.has_key?(choice)
            how_many = 0
            points = nums[choice] * hand.count_nums[nums[choice]]
            player.score[choice] = points
        elsif choice == 'escalera'
            if hand.sorted == [1,2,3,4,5] || hand.sorted == [2,3,4,5,6]
                player.score['escalera'] = 20
                player.score['escalera'] = 25 if i == 1
            else
                player.score['escalera'] = 0
            end
        else
            hand_count = hand.count_nums
            if choice == 'full'
                if hand_count.has_value?(2) && hand_count.has_value?(3)
                    player.score['full'] = 30
                    player.score['full'] = 35 if i == 1
                else
                    player.score['full'] = 0
                end
            elsif choice == 'poker'
                if hand_count.has_value?(4)
                    player.score['poker'] = 40
                    player.score['poker'] = 45 if i == 1
                else
                    player.score['poker'] = 0
                end
            else
                if hand_count.has_value?(5)
                    if i == 1
                        p player.name + " wins the game!"
                        return
                    end
                    player.score['generala'] = 50
                else
                    player.score['generala'] = 0
                end
            end
        end
        new_arr = []
        player.available.each {|ele| new_arr << ele if ele != choice}
        player.available = new_arr
        true
    end

    def done?
        @players.each {|player| return false if player.available != []}
        true
    end

    def play
        while !done?
            turn
        end
        players.each do |player|
            total_score = 0
            player.score.each_value {|v| total_score += v}
            p player.name + ' got ' + total_score.to_s + ' points!'
        end

    end
end


game = Game.new("Daniel","Pia")
#p1 = game.players[0]
#p2 = game.players[1]
#game.score(p1,[1,4,2,1,1],'uno')
#p p1.score
#p p1.available
#game.score(p1,[1,3,4,2,5],'escalera')
#p p1.score
#p p1.available
#game.score(p1,[1,3,4,2,5],'generala')
#p p1.score
#p p1.available
#game.score(p1,[1,2,2,1,1],'full')
#game.turn
#p p1.score
#p p1.available
game.play
#p game.score(p1,[1,1,1,2,2],'full',1)
#p p1.score
#p game.score(p1,[1,1,1,2,2],'full',2)
#p p1.score
#p game.score(p1,[1,2,3,4,5],'generala',1)
#p p1.score
#p game.score(p1,[5,5,5,5,5],'generala',1)



