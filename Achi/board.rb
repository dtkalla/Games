require_relative "piece"
require_relative "null_piece"
require_relative "player"

class Board

    def initialize(num_pieces)
        @grid = Array.new(3) { Array.new(3) {NullPiece.new} }
        @num_pieces = num_pieces
    end

    def render
        puts show_row(@grid[0])
        puts '|\ | /|'
        puts '| \|/ |'
        puts show_row(@grid[1])
        puts '| /|\ |'
        puts '|/ | \|'
        puts show_row(@grid[2])
    end

    def show_row(row)
        row = row.map { |ele| ele.print }
        row.join('--')
    end

    def win?(color)
        row_win?(color) || col_win?(color) || diag_win?(color)
    end

    def row_win?(color)
        @grid.any? { |row| row.all? {|ele| ele.color == color} }
    end

    def col_win?(color)
        @grid.transpose.any? { |col| col.all? {|ele| ele.color == color} }
    end

    def diag_win?(color)
        return true if (0..2).all? { |i| @grid[i][i].color == color }
        return true if (0..2).all? { |i| @grid[i][2-i].color == color }
        false
    end

    def game_over?
        win?(:white) || win?(:blue)
    end

    def placement_over?(color)
        count = Hash.new(0)
        @grid.flatten.each { |piece| count[piece.color] += 1 }
        count[:blue] == @num_pieces && count[:white] == @num_pieces
    end

    def place_piece(player,pos)
        color = player.color
        row,col = pos
        @grid[row][col] = Piece.new(color)
    end

end

board = Board.new(4)
player1 = Player.new("Daniel",:white)
player2 = Player.new("Marion",:blue)
board.place_piece(player1,[1,0])
board.place_piece(player2,[1,1])
board.render
