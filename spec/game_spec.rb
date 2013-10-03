require 'spec_helper'
require File.join(File.dirname(__FILE__), '../lib', 'game')

describe Game do

  describe "initialization" do
    context "directly" do
      subject { Game.new(5, 4, 1.0, 1) }

      its(:height) { should eql(4) }
      its(:width)  { should eql(5) }
      its(:steps)  { should eql(1) }
    end

    context "from a file" do
      let(:file) { File.open('spec/support/example_board.txt') }
      let(:invalid_file_1) { File.open('spec/support/board_without_rows.txt') }
      let(:invalid_file_2) { File.open('spec/support/board_with_invalid_rows.txt') }
      let(:invalid_file_3) { File.open('spec/support/board_with_invalid_cells.txt') }
      subject { Game.import_board(file) }

      context "that is valid" do
        subject { Game.import_board(file) }
        its(:height) { should eql(3) }
        its(:width)  { should eql(3) }
        its(:steps)  { should eql(100) }
      end

      context "that specifies no rows" do
        it "should throw an error" do
          $stderr.should_receive(:puts).with('INVALID BOARD! At least one row must be defined')
          lambda { Game.import_board(invalid_file_1); exit }.should raise_error SystemExit
        end
      end

      context "that specifies invalid rows" do
        it "should throw an error" do
          $stderr.should_receive(:puts).with('INVALID BOARD! Rows must all be same length')
          lambda { Game.import_board(invalid_file_2); exit }.should raise_error SystemExit
        end
      end

      context "that specifies invalid cells" do
        it "should throw an error" do
          $stderr.should_receive(:puts).with('INVALID BOARD! Cells must be defined using spaces or the letter\'o\'')
          lambda { Game.import_board(invalid_file_3); exit }.should raise_error SystemExit
        end
      end
    end
  end
end
