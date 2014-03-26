require File.join(File.dirname(__FILE__), 'cell')

class GameMaster
  def self.import_board!(game, file, cycles)
    board = file.read
    verify_board board
    rows         = board.split(/\r?\n/)
    game.height  = rows.length
    game.width   = rows.first.length
    game.cycles  = cycles.to_i
    game.seed_cells!(board)
  end

  def self.initialize_board!(game, width, height, seed_probability, cycles)
    game.width  = width.to_i
    game.height = height.to_i
    game.cycles = cycles.to_i
    game.cells  = Array.new(game.height) { Array.new(game.width) { Cell.new(seed_probability.to_f) } }
    game
  end


  private

  def self.verify_board(board)
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

  def self.exit_with_error(message)
    $stderr.puts(message)
    exit 2
  end
end
