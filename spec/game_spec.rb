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
    subject { Game.new(5, 4, 1.0, 1) }

    its(:height) { should eql(4) }
    its(:width)  { should eql(5) }
    its(:steps)  { should eql(1) }
  end
end
