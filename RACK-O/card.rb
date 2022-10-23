class Card
    attr_reader :number
    attr_accessor :color
    
    def initialize(number)
        @number = number
        @color = :red
    end

    def print
        @number.to_s.colorize(color)
    end

end