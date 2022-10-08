require "colorize"

class Piece
    attr_reader :color

    def initialize(color)
        @color = color
    end
    
    def print
        '⬤'.colorize(@color)
    end

end