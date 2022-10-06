require 'colorize'

class Card
    NUM_HASH = {1 => 'A', 10 => 'T', 11 => 'J', 12 => 'Q', 13 => 'K'}

    def initialize(number,suit)
        @number = number
        @number_sign = number.to_s
        @number_sign = NUM_HASH[number] if number == 1 || number >= 10
        @suit = suit
        @facedown = false
        @color = ['♦','♥'].include?(suit) ? :red : :black
    end

    def show
        return '??' if @facedown
        return "#{@number_sign}#{@suit}".colorize(:red) if @color == :red
        "#{@number_sign}#{@suit}".colorize(:blue) if @color == :black
    end

    def turn_over
        @facedown = false
    end

end