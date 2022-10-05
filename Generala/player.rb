require_relative "hand"

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
