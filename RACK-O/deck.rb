require_relative "card"

class Deck

    def initialize
        @cards = []
        populate
    end

    def deal
        hand = []
        10.times { hand << @cards.pop }
        hand
    end

    def draw
        @cards.pop
    end

    def empty?
        @cards.empty?
    end

    def repopulate(discard_pile)
        @cards = discard_pile.shuffle
        true
    end

    private
    def populate
        (1..60).to_a.each { |num| @cards << Card.new(num) }
        @cards = @cards.shuffle
    end

end