unless defined? Cell
  require File.join(File.dirname(__FILE__), 'cell')
end
unless defined? GameMaster
  require File.join(File.dirname(__FILE__), 'game_master')
end

class Game
  attr_accessor :width, :height, :cycles, :cells

  def initialize(file: nil, width: 100, height: 50, seed_probability: 0.1, cycles: 100)
    file ?
      GameMaster.import_board!(self, file, cycles) :
      GameMaster.initialize_board!(self, width, height, seed_probability, cycles)
  end

  def play!
    (1..cycles.to_i).each do
      next!
      system('clear')
      puts self
      sleep(0.1)
    end
  end

  def next!
    cells.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        cell.neighbors = alive_neighbours(y, x)
      end
    end
    cells.flatten.map(&:next!)
  end

  def alive_neighbours(y, x)
    [[-1, 0], [1, 0],
     [-1, 1], [0, 1], [1, 1],
     [-1, -1], [0, -1], [1, -1]
    ].inject(0) do |sum, offset|
      y_offset, x_offset = offset
      sum + @cells[(y + y_offset) % height][(x + x_offset) % width].to_i
    end
  end

  def to_s
    cells.map { |row| row.join }.join("\n")
  end

  def seed_cells!(board)
    _cells = Array.new(height) { Array.new(width) }
    board.split(/\r?\n/).each_with_index do |row, y|
      row.split(//).each_with_index do |cell, x|
        is_alive = cell=='o' ? 1 : 0
        _cells[y][x] = Cell.new(is_alive)
      end
    end
    @cells = _cells
  end
end
