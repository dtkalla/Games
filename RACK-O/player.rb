require_relative "deck"
require "colorize"

class Player
    attr_reader :name

    def initialize(name,deck)
        @name = name
        @rack = deck.deal
    end

    def render
        card_nums = []
        colorize
        @rack.each { |card| card_nums << card.print }
        puts card_nums.join(' ')
    end

    def colorize
        @rack.each_with_index do |card,index|
            card.color = :red
            if index == 0
                card.color = :blue if card.number < @rack[index+1].number
            elsif index == 9
                card.color = :blue if card.number > @rack[index-1].number
            else
                card.color = :blue if card.number < @rack[index+1].number && card.number > @rack[index-1].number
            end
        end
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

