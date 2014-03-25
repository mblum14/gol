unless defined? Cell
  require File.join(File.dirname(__FILE__), 'cell')
end

class Game
  attr_reader :width, :height, :steps

  # TODO
  # 1. refactor using keyword arguments
  # 2. initialize with either specified dimensions or file
  def initialize(width, height, seed_probability, steps)
    @width, @height, @steps = width.to_i, height.to_i, steps.to_i
    @cells = Array.new(@height) { Array.new(@width) { Cell.new(seed_probability.to_f) } }
  end

  # TODO
  # 1. Refactor this functionality into the class initializer
  def self.import_board file, iterations=100
    board = file.read
    verify_board board
    rows   = board.split(/\r?\n/)
    height = rows.length
    width  = rows.first.length
    game   = Game.new(width, height, 0, iterations)
    game.seed_cells!(board)
    return game
  end

  def play!
    (1..@steps).each do
      next!
      system('clear')
      puts self
      sleep(0.1)
    end
  end

  def next!
    # TODO
    # 1. shouldn't this calculation be on the cell?
    @cells.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        cell.neighbors = alive_neighbours(y, x)
      end
    end
    @cells.flatten.map(&:next!)
  end

  def alive_neighbours(y, x)
    [[-1, 0], [1, 0],           # left and right
     [-1, 1], [0, 1], [1, 1],   # above
     [-1, -1], [0, -1], [1, -1] # below
    ].inject(0) do |sum, offset|
      y_offset, x_offset = offset
      sum + @cells[(y + y_offset) % @height][(x + x_offset) % @width].to_i
    end # count number of live cells
  end

  def to_s
    @cells.map { |row| row.join }.join("\n")
  end

  def seed_cells!(board)
    _cells = Array.new(@height) { Array.new(@width) }
    board.split(/\r?\n/).each_with_index do |row, y|
      row.split(//).each_with_index do |cell, x|
        is_alive = cell=='o' ? 1 : 0
        _cells[y][x] = Cell.new(is_alive)
      end
    end
    @cells = _cells
  end

  private

  def self.verify_board board
    rows = board.split(/\r?\n/)
    # verify rows exist
    if rows.length.zero?
      exit_with_error('INVALID BOARD! At least one row must be defined')
    end

    # verify rows are all the same length
    unless rows.map(&:length).uniq.count == 1
      exit_with_error('INVALID BOARD! Rows must all be same length')
    end

    # verify the characters used are either a space or 'o'
    if !!board.gsub(/[\\r\\n]+/, "").match(/[^o\s]/)
      exit_with_error('INVALID BOARD! A cell must be defined using a space or the letter \'o\'')
    end
  end

  def self.exit_with_error message
    $stderr.puts(message)
    exit 2
  end
end
