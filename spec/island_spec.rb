require_relative "spec_helper"

describe "Island::find_neighbours" do
    it "Find the neighbours in the grid" do
        vec = { :x => 1, :y => 2 }
        limit = { :min => 0, :max => 10 }
        neighbours = Island.find_neighbours(vec, limit, limit)

        neighbours.length.should eq 4
    end
end

describe "Island::generate" do
    it "Generate a random collection of tiles" do
        
    end
end
