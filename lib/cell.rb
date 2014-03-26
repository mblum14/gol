class Cell
  attr_writer :number_of_neighbors

  def initialize(seed_probability)
    @alive = seed_probability > rand
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
