require File.join(File.dirname(__FILE__), 'cell')
require File.join(File.dirname(__FILE__), 'board')

class Game
  attr_reader :board, :cycles

  def initialize(cycles: 100, **options)
    @cycles = cycles.to_i
    @board = Board.new(options)
  end

  def play!
    (1..@cycles.to_i).each do
      @board.next_generation!
      system('clear')
      puts @board
      sleep(0.1)
    end
  end
end
