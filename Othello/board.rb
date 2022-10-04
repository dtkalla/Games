require_relative "player.rb"

class Board

    def initialize
        @board = Array.new(8) {Array.new(8,:_)}
        @board[3][3] = :B
        @board[3][4] = :W
        @board[4][3] = :W
        @board[4][4] = :B
#        @board[0][6] = :W
#        @board[0][5] = :B        
    end

    def print
        @board.each {|line| p line.join(' ')}
    end

    def get_lines(pos)
        i,j = pos
        right = generate(i,j,0,1)
        left = generate(i,j,0,-1)
        up = generate(i,j,-1,0)
        down = generate(i,j,1,0)
        ne = generate(i,j,-1,1)
        nw = generate(i,j,-1,-1)
        sw = generate(i,j,1,-1)
        se = generate(i,j,1,1)        
        [right,left,up,down,ne,nw,sw,se]
    end

    def is_valid?(pos,color)
        if color == :W then opp = :B else opp = :W end
        possibles = get_lines(pos)
        possibles.each {|line| return true if line[0] == opp && line.include?(color)}
        false
    end
    
    def generate(row,col,row_change,col_change)
        arr = []
        row += row_change
        col += col_change
        while row >= 0 && row <= 7 && col >= 0 && col <= 7
            arr << @board[row][col]
            row += row_change
            col += col_change
        end
        arr
    end

    def place(pos,color)
        idxs = valid_indices(pos,color)
        if color == :W then opp = :B else opp = :W end
        i,j = pos
        @board[i][j] = color
        change_dict = {0 => [0,1], 1 => [0,-1], 2 => [-1,0], 3 => [1,0],
        4 => [-1,1], 5 => [-1,-1], 6 => [1,-1], 7 => [1,1],}
        idxs.each do |idx|
            a,b = change_dict[idx]
            i += a
            j += b
            while @board[i][j] == opp
                @board[i][j] = color
                i += a
                j += b
            end
            i,j = pos
        end
    end

    def position(arr)
        @board[arr[0]][arr[1]]
    end

    def valid_indices(pos,color)
        if color == :W then opp = :B else opp = :W end
        lines = get_lines(pos)
        arr = []
        lines.each.with_index {|line,i| arr << i if line[0] == opp && line.include?(color)}
        arr
    end

#    def []=(pos,value)
#        row,col = pos
#        @board[row][col] = value
#    end

    def score(player)
        player.score = 0
        (0..7).each do |i|
            (0..7).each {|j| player.score += 1 if @board[i][j] == player.color}
        end
        player.score
    end

    def board_full?
        @board.each {|line| line.each {|ele| return false if ele == :_}}
        true
    end

end



"""
board_1 = Board.new
board_1.print


p board_1.get_lines([3,3])
p board_1.is_valid?([3,2],:W)
p board_1.is_valid?([3,2],:B)
puts
p board_1.get_lines([3,2])
p board_1.valid_indices([3,2],:W)

board_1.place([3,2],:W)
board_1.print
puts

board_1.place([4,2],:B)
board_1.print
puts

p board_1.get_lines([5,4])
p board_1.valid_indices([5,4],:W)
board_1.place([5,4],:W)
board_1.print
puts

board_1.place([4,5],:B)
board_1.print
puts

board_1.place([5,1],:W)
board_1.print
puts

board_1.place([4,1],:B)
board_1.print
puts

board_1.place([5,0],:W)
board_1.print
puts

board_1.place([6,0],:B)
board_1.print
puts

board_1.place([7,0],:W)
board_1.print
puts

p board_1.get_lines([3,1])
p board_1.valid_indices([3,1],:B)
board_1.place([3,1],:B)
board_1.print
puts

p1 = Player.new(:B)
p2 = Player.new(:W)
board_1.score(p1)
board_1.score(p2)
p p1.score
p p2.score
"""