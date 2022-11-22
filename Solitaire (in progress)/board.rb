require_relative "deck"

class Board

    def initialize
        @deck = Deck.new
        @deck.shuffle
        @lower_board = Array.new(7) { [] }
    end

    def populate_board
        (0..6).each do |i|
            (0..i).each do |j|
                card = @deck.deck.pop
                card.turn_over if i == j
                @lower_board[i] << card
            end
        end
        @lower_board = @lower_board.reverse
    end

    def print_board
        @lower_board.each do |row|
            cards = []
            (7 - row.length).times { cards << '  ' }
            row.each { |card| cards << card.show }
            puts cards.join(' ')
        end
    end
end

board = Board.new
board.populate_board
board.print_board