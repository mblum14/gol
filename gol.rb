require 'bundler'
Bundler.require
require File.join(File.dirname(__FILE__), 'lib', 'cell')
require File.join(File.dirname(__FILE__), 'lib', 'game')

def usage message
  $stderr.puts(message)
  $stderr.puts("Usage: #{File.basename($0)}: [-h <height>] [-w <width>] [-p <probability>] [-i <iterations>] [-f <FILE>]")
  $stderr.puts("  -h <height>           (default 50)the height of the game board")
  $stderr.puts("  -w <width>            (default 100) the width of the game board")
  $stderr.puts("  -p <probability>      (default 0.1) seed probability for generating live and dead cells")
  $stderr.puts("  -i <iterations>       (default 100) number of life cylces")
  $stderr.puts("  -f <FILE>             provide an existing game board to start with")
  exit 2
end

height      = 50
width       = 100
probability = 0.1
iterations  = 100
board_file  = nil

loop do
  case ARGV[0]
  when '--help' then usage('')
  when '-h' then  ARGV.shift; height = ARGV.shift
  when '-w' then  ARGV.shift; width = ARGV.shift
  when '-p' then  ARGV.shift; probability = ARGV.shift
  when '-i' then  ARGV.shift; iterations = ARGV.shift
  when '-f' then  ARGV.shift; board_file = ARGV.shift
  when /^-/ then  usage("Unknown option: #{ARGV[0].inspect}")
  else break
  end
end

if board_file
  Game.import_board(File.open(board_file), probability, iterations).play!
else
  Game.new(width, height, probability, iterations).play!
end
