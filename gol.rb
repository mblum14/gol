require 'bundler'
Bundler.require
require File.join(File.dirname(__FILE__), 'lib', 'cell')
require File.join(File.dirname(__FILE__), 'lib', 'game')
require File.join(File.dirname(__FILE__), 'lib', 'board')

def usage message
  $stderr.puts(message)
  $stderr.puts("Usage: #{File.basename($0)}: [-h <height>] [-w <width>] [-p <probability>] [-i <iterations>] [-f <FILE>]")
  $stderr.puts("  -h <height>           (default 50)the height of the game board")
  $stderr.puts("  -w <width>            (default 100) the width of the game board")
  $stderr.puts("  -p <probability>      (default 0.1) seed probability for generating live and dead cells")
  $stderr.puts("  -c <cycles>           (default 100) number of life cylces")
  $stderr.puts("  -f <FILE>             provide an existing game board to start with")
  exit 2
end

options = {}

loop do
  case ARGV[0]
  when '--help' then usage('')
  when '-h' then  ARGV.shift; options[:height] = ARGV.shift
  when '-w' then  ARGV.shift; options[:width] = ARGV.shift
  when '-p' then  ARGV.shift; options[:seed_probability] = ARGV.shift
  when '-c' then  ARGV.shift; options[:cycles] = ARGV.shift
  when '-f' then  ARGV.shift; options[:file] = File.open(ARGV.shift)
  when /^-/ then  usage("Unknown option: #{ARGV[0].inspect}")
  else break
  end
end

Game.new(options).play!
