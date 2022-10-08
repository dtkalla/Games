require_relative "deck"

class Player
    attr_reader :name

    def initialize(name,deck)
        @name = name
        @rack = deck.deal
    end

    def render
        card_nums = []
        @rack.each { |card| card_nums << card.number.to_s}
        puts card_nums.join(' ')
    end

    def won?
        (0..8).all? { |i| @rack[i].number < @rack[i+1].number }
    end

    def replace_card(index,new_card)
        return new_card if index == 0
        index -= 1
        old_card = @rack[index]
        @rack[index] = new_card
        old_card
    end

end

