class Player
    attr_reader :color
    attr_accessor :score

    def initialize(color)
        @color = color
        @score = 2
    end


end

#p1 = Player.new(:B)
#p2 = Player.new(:W)
#p 'Black has a score of ' + p1.score.to_s
#p 'White has a score of ' + p2.score.to_s
#p1.score = 3
#p2.score = 1
#p 'Black has a score of ' + p1.score.to_s
#p 'White has a score of ' + p2.score.to_s