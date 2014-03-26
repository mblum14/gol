require 'spec_helper'
require File.join(File.dirname(__FILE__), '../lib', 'game')

describe Game do
  describe "initialization" do
    context "directly" do
      subject { Game.new(width: 5, height: 4, seed_probability: 1.0, cycles: 1) }

      its(:height) { should eql(4) }
      its(:width)  { should eql(5) }
      its(:cycles)  { should eql(1) }
    end

    context "from a file" do
      let(:file) { File.open('spec/support/example_board.txt') }
      let(:invalid_file_1) { File.open('spec/support/board_without_rows.txt') }
      let(:invalid_file_2) { File.open('spec/support/board_with_invalid_rows.txt') }
      let(:invalid_file_3) { File.open('spec/support/board_with_invalid_cells.txt') }
      subject { Game.new(file: file) }

      context "that is valid" do
        subject { Game.new(file: file) }
        its(:height) { should eql(3) }
        its(:width)  { should eql(3) }
        its(:cycles)  { should eql(100) }
      end

      context "that specifies no rows" do
        it "should throw an error" do
          $stderr.should_receive(:puts).with('INVALID BOARD! At least one row must be defined')
          lambda { Game.new(file: invalid_file_1); exit }.should raise_error SystemExit
        end
      end

      context "that specifies invalid rows" do
        it "should throw an error" do
          $stderr.should_receive(:puts).with('INVALID BOARD! Rows must all be same length')
          lambda { Game.new(file: invalid_file_2); exit }.should raise_error SystemExit
        end
      end

      context "that specifies invalid cells" do
        it "should throw an error" do
          $stderr.should_receive(:puts).with('INVALID BOARD! A cell must be defined using a space or the letter \'o\'')
          lambda { Game.new(file: invalid_file_3); exit }.should raise_error SystemExit
        end
      end
    end
  end

  context '#alive_neighbors' do
    (0..8).each do |neighbour_count|
      context "#{neighbour_count} of them" do
        TestBoardGenerator.new(neighbour_count).permutations do |board_file|
          subject {  Game.new(board_file) }
          it "should find #{neighbour_count}" do
            expect(Game.new(file:board_file).alive_neighbors(1, 1)).to eql(neighbour_count)
          end
        end
      end
    end
  end
end
