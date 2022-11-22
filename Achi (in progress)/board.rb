require_relative "piece"
require_relative "null_piece"
require_relative "player"

class Board

    def initialize(num_pieces)
        @grid = Array.new(3) { Array.new(3) {NullPiece.new} }
        @num_pieces = num_pieces
        @conversion = create_conversion_hash
    end

    def create_conversion_hash
        hash = Hash.new
        (0..2).each do |i|
            (0..2).each do |j|
                hash[[i,j]] = 3*i + j + 1
                hash[3*i + j + 1] = [i,j]
            end
        end
        hash
    end

    def render
        puts show_row(@grid[0]) + "          1--2--3"
        puts '|\ | /|          |\ | /|'
        puts '| \|/ |          | \|/ |'
        puts show_row(@grid[1]) + "          4--5--6"
        puts '| /|\ |          | /|\ |'
        puts '|/ | \|          |/ | \|'
        puts show_row(@grid[2]) + "          7--8--9"
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

    def possible_moves(color)
        moves_hash = {1 => [2,4,5], 2 => [1,3,5], 3  => [2,5,6], 4 => [1,5,7],
        5 => [1,2,3,4,6,7,8,9],  6 => [3,5,9], 7 => [4,5,8], 8 => [5,7,9], 9 => [5,6,8] }
        empty_spaces = (1..9).to_a.select { |pos| empty?(pos) }
        current_spaces = (1..9).to_a.select do |pos|
            row,col = @conversion[pos]
            @board[row][col].color == color
        end
        possible_moves = []
        
    end

    # def placement_over?(color)
    #     count = Hash.new(0)
    #     @grid.flatten.each { |piece| count[piece.color] += 1 }
    #     count[:blue] == @num_pieces && count[:white] == @num_pieces
    # end

    def place_piece(player,pos)
        row,col = @conversion[pos]
        @grid[row][col] = Piece.new(player.color)
    end

    def empty?(pos)
        row,col = @conversion[pos]
        @board[row][col].color == :yellow
    end

end

board = Board.new(4)
player1 = Player.new("Daniel",:white)
player2 = Player.new("Marion",:blue)
board.place_piece(player1,4)
board.place_piece(player2,5)
board.render
