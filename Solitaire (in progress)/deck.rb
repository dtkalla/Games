require_relative "card"

class Deck
    attr_reader :deck

    def initialize
        @deck = []
        (1..13).each do |number|
            ['♦','♣','♥','♠'].each { |suit| @deck << Card.new(number,suit) }
        end
    end

    def shuffle
        @deck = @deck.shuffle
    end

    def print
        @deck.each { |card| puts card.show }
    end

end

# deck = Deck.new
# deck.shuffle
# deck.print