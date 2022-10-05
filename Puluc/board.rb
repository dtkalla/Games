class Board

    def initialize
        @grid = Array.new(11) { [] }
        @grid[0] = ["Goal for black pieces", :W, :W, :W, :W, :W]
        @grid[-1] = ["Goal for white pieces", :B, :B, :B, :B, :B]
    end

    def win?(mark)
        check = @grid[0] + @grid[-1]
        (1..9).each do |i|
            check << @grid[i][0] if !@grid[i].empty?
        end
        !check.include?(mark)
    end

    def game_over?
        win?(:B) || win?(:W)
    end

    def roll_dice
        total = 0
        4.times { total += rand(0..1) }
        num = 5 - total
        num
    end

    def display_pieces
        white_pieces = @grid.flatten.count { |ele| ele == :W }
        black_pieces = @grid.flatten.count { |ele| ele == :B }
        puts "White has #{white_pieces} left."
        puts "Black has #{black_pieces} left."
    end

    def valid_move?(index,color,amount)
        if index == 0
            return false if @grid[0].length == 1 
            return @grid[amount][0] != color
        end
        return false if @grid[index] == [] || @grid[index][0] != color #no piece there
        return true if index + amount > 9 #move is valid if it ends in or past the goal
        @grid[index + amount][0] != color #can't land on your own piece
    end

    def possible_moves(color,amount)
        (0..9).select { |index| valid_move?(index,color,amount) }
    end

    def change_turns
        @grid = @grid.reverse
    end

    def make_move(index,amount)
        if index == 0
            moving_pieces = [@grid[0].pop]
        else
            moving_pieces = @grid[index]
            @grid[index] = []
        end
        new_index = index + amount
        if new_index < 10
            @grid[new_index] = moving_pieces + @grid[new_index]
        else
            survivors = moving_pieces.select { |ele| ele == moving_pieces[0] }
            @grid[0] += survivors
        end
    end

    def print
        system("clear")
        @grid.reverse.each_with_index do |row,index|
            p row
        end
    end

end
