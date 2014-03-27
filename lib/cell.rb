class Cell

  attr_accessor :number_of_neighbors

  def initialize(x, y, seed_probability)
    @x     = x
    @y     = y
    @alive = seed_probability > rand
  end

  def count_neighbors!(board)
    @number_of_neighbors = [-1, -1, 0, 1, 1].permutation(2).to_a.uniq.inject(0) do |sum, offset|
      y_offset, x_offset = offset
      sum + board.cells[(@y + y_offset) % board.height][(@x + x_offset) % board.width].to_i
    end
  end

  def next!
    @alive = alive? ? has_two_or_three_neighbors? : has_three_neighbors?
  end

  def to_i
    @alive ? 1 : 0
  end

  def to_s
    @alive ? 'o' : ' '
  end

  def alive?
    @alive
  end

  private

  def has_two_or_three_neighbors?
    (2..3) === @number_of_neighbors
  end

  def has_three_neighbors?
    3 == @number_of_neighbors
  end
end
