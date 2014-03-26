unless defined? StringIO
  require 'stringio'
end

class TestBoardGenerator

  def initialize(number_of_neighbors)
    @alive_and_dead = Array.new(8, ' ')
    @board = ''

    number_of_neighbors.times do
      @alive_and_dead.pop
      @alive_and_dead.unshift('o')
    end
  end

  def permutations
    boards = []
    @alive_and_dead.permutation(8).to_a.uniq.each do |permutation|
      permutation.insert(4, 'o')
      permutation.each_slice(3) do |row|
        @board << row.push("\n").join
      end
      io = StringIO.new(@board.chomp)
      boards << io
      yield io if block_given?
    end
    boards.to_enum
  end
end
