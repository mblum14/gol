require 'spec_helper'
require File.join(File.dirname(__FILE__), '../lib', 'game')

describe Game do
  let(:board) {
    <<-BOARD
      ooooo
      ooooo
      ooooo
      ooooo
    BOARD
  }
  describe "initialization" do
    context "directly" do
      subject { Game.new(5, 4, 1.0, 1) }

      its(:height) { should eql(4) }
      its(:width)  { should eql(5) }
      its(:steps)  { should eql(1) }
    end

    context "from a file" do
      let(:file) { File.open('spec/example_board.txt') }
      subject { Game.import_board(file) }

      its(:height) { should eql(3) }
      its(:width)  { should eql(3) }
      its(:steps)  { should eql(100) }

    end
  end
end
