require 'spec_helper'
require File.join(File.dirname(__FILE__), '../lib', 'cell')

describe Cell do
  let(:live_cell) { Cell.new(0, 0, 1) }
  let(:dead_cell) { Cell.new(0, 0, 0) }

  describe "initialization" do
    it 'initializes a cell with a probability to be alive' do
      expect(live_cell).to be_alive
      expect(dead_cell).to_not be_alive
    end
  end

  describe "#to_i" do
    it "returns 1 if it is alive" do
      expect(live_cell.to_i).to eql(1)
    end

    it "returns 0 if it is dead" do
      expect(dead_cell.to_i).to eql(0)
    end
  end

  describe "#to_s" do
    it "is represented by a 'o' if it is alive" do
      expect(live_cell.to_s).to eql('o')
    end

    it "is represented by a space if it is dead" do
      expect(dead_cell.to_s).to eql(' ')
    end
  end

  describe '#count_neighbors!' do
    (0..8).each do |neighbor_count|
      context "#{neighbor_count} of them" do
        TestBoardGenerator.new(neighbor_count).permutations do |board_file|
          it "should find #{neighbor_count}" do
            board = Board.new(file: board_file)
            cell = Cell.new(1, 1, 1)
            cell.count_neighbors!(board)
            expect(cell.number_of_neighbors).to eql(neighbor_count)
          end
        end
      end
    end
  end

  describe "#!next" do
    context "given a dead cell" do
      let(:cell) { dead_cell }

      it "will remain dead with 0 neighbors" do
        cell.number_of_neighbors = 0
        cell.next!
        expect(cell).to_not be_alive
      end

      it "will remain dead with 1 neighbor" do
        cell.number_of_neighbors = 1
        cell.next!
        expect(cell).to_not be_alive
      end

      it "will remain dead with 2 neighbors" do
        cell.number_of_neighbors = 2
        cell.next!
        expect(cell).to_not be_alive
      end

      it "will become alive with 3 neighbors" do
        cell.number_of_neighbors = 3
        cell.next!
        expect(cell).to be_alive
      end

      it "will remain dead with 4 neighbors" do
        cell.number_of_neighbors = 4
        cell.next!
        expect(cell).to_not be_alive
      end

      it "will remain dead with 5 neighbors" do
        cell.number_of_neighbors = 5
        cell.next!
        expect(cell).to_not be_alive
      end

      it "will remain dead with 6 neighbors" do
        cell.number_of_neighbors = 6
        cell.next!
        expect(cell).to_not be_alive
      end

      it "will remain dead with 7 neighbors" do
        cell.number_of_neighbors = 7
        cell.next!
        expect(cell).to_not be_alive
      end
    end

    context "given a live cell" do
      let(:cell) { live_cell }

      it "will be dead with 0 neighbors" do
        cell.number_of_neighbors = 0
        cell.next!
        expect(cell).to_not be_alive
      end

      it "will be dead with 1 neighbor" do
        cell.number_of_neighbors = 1
        cell.next!
        expect(cell).to_not be_alive
      end

      it "will remain alive with 2 neighbors" do
        cell.number_of_neighbors = 2
        cell.next!
        expect(cell).to be_alive
      end

      it "will remain alive with 3 neighbors" do
        cell.number_of_neighbors = 3
        cell.next!
        expect(cell).to be_alive
      end

      it "will be dead with 4 neighbors" do
        cell.number_of_neighbors = 4
        cell.next!
        expect(cell).to_not be_alive
      end

      it "will be dead with 5 neighbors" do
        cell.number_of_neighbors = 5
        cell.next!
        expect(cell).to_not be_alive
      end

      it "will be dead with 6 neighbors" do
        cell.number_of_neighbors = 6
        cell.next!
        expect(cell).to_not be_alive
      end

      it "will be dead with 7 neighbors" do
        cell.number_of_neighbors = 7
        cell.next!
        expect(cell).to_not be_alive
      end
    end
  end
end
