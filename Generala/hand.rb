class Hand
    attr_reader :value, :hand

    def initialize
        @hand = [1,2,3,4,5]
    end

    def roll(idxs = [0,1,2,3,4])
        idxs.each {|idx| @hand[idx] = rand(1..6)}
        @hand
    end

    def print
        p @hand.join(' ')
    end

    def count_nums
        count = Hash.new(0)
        @hand.each {|die| count[die] += 1}
        count
    end

    def sorted
        @hand.sort
    end

end

#hand = Hand.new
#hand.print
#p hand.count_nums
#hand.roll([0,3])
#hand.print
#p hand.count