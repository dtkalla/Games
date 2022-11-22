require "colorize"

class NullPiece
    attr_reader :color

    def initialize(color=:yellow)
        @color = color
    end
    
    def print
        'O'.colorize(@color)
    end

end