require File.join(File.dirname(__FILE__), 'cell')

class Board

  attr_reader :width, :height, :cells

  def initialize(file: nil, width: 100, height: 50, seed_probability: 0.1)
    file ?
      initialize_from_file!(file) :
      initialize_from_parameters!(width, height, seed_probability)
  end

  def next_generation!
    cells.flatten.map { |cell| cell.count_neighbors!(self) }
    cells.flatten.map(&:next!)
  end

  def to_s
    cells.map { |row| row.join }.join("\n")
  end

  private

  def initialize_from_file!(file)
    layout = file.read
    verify_layout(layout)

    rows   = layout.split(/\r?\n/)
    @height = rows.length
    @width  = rows.first.length
    seed_cells!(layout)
  end

  def initialize_from_parameters!(width, height, seed_probability)
    @height = height.to_i
    @width  = width.to_i
    @cells  = Array.new(height) { |y| Array.new(width) { |x| Cell.new(x, y, seed_probability.to_f) } }
  end

  def seed_cells!(layout)
    _cells = Array.new(height) { Array.new(width) }
    layout.split(/\r?\n/).each_with_index do |row, y|
      row.split(//).each_with_index do |cell, x|
        is_alive = cell == 'o' ? 1 : 0
        _cells[y][x] = Cell.new(x, y, is_alive)
      end
    end
    @cells = _cells
  end

  def verify_layout(layout)
    rows = layout.split(/\r?\n/)
    # verify rows exist
    if rows.length.zero?
      exit_with_error('INVALID BOARD! At least one row must be defined')
    end

    # verify rows are all the same length
    unless rows.map(&:length).uniq.count == 1
      exit_with_error('INVALID BOARD! Rows must all be same length')
    end

    # verify the characters used are either a space or 'o'
    if !!layout.gsub(/[\\r\\n]+/, "").match(/[^o\s]/)
      exit_with_error('INVALID BOARD! A cell must be defined using a space or the letter \'o\'')
    end
  end

  def exit_with_error(message)
    $stderr.puts(message)
    exit 2
  end
end
