require_relative "hand.rb"

class Player
    attr_reader :name,:score,:available
    attr_writer :available

    def initialize(name)
        @name = name
        @available = ['uno', 'dos', 'tres', 'cuatro', 'cinco', 'seis',
        'escalera', 'full', 'poker', 'generala']
        @score = Hash.new
        @available.each {|ele| @score[ele] = :_}
    end

    def []=(key,num)
        @score[key] = num
    end

end

#player_1 = Player.new("Daniel")

#p player_1

#player_1['uno'] = 3
#p player_1.score


