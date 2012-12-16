require_relative "island_tiles"
require "chingu"

include Chingu

# An area impassable to ships
# Other things can be built onto it
class Island < GameObjectMap 
    def initialize(options = {})
        super(options)
        @width = @grid[0]
        @height = @grid[1]

        island_size = 20
        island_size = options[:island_size] if options[:island_size]

        generate island_size

        # Create the drawable objects
        @land.each do |point|
            Grass.create(
                  :image => Image["grass.png"],
                  :x => point[:x] * @grid[0],
                  :y => point[:y] * @grid[1]
            )
        end

        make_dock
    end

    def generate size
        border_x = {:min => 0, :max => $viewport[:width] }
        border_y = { :min => 0, :max => $viewport[:height] }

        x_start = rand(border_x[:max]/@width)
        y_start = rand(border_y[:max]/@height)

        land = []
        land.push( { :x => x_start, :y => y_start } )


        # Consider storing first land as a var
        neighbours = Island.find_neighbours(land.first, border_x, border_y)

        # Create a 10 tile island
        for i in 0..size do
            if neighbours.length < 1
                break
            end

            # Select a random neighbour node
            index = rand(neighbours.length)
            tempNode = neighbours[index] 

            # Remove from list
            neighbours.delete_at index
            
            neighbours += Island.find_neighbours(tempNode, border_x, border_y)
            land.push tempNode
        end

        @land = land
        @coast = neighbours
    end

    # Return a list of co-ords above and below, but within the limits
    #
    # Should be a helper method
    def self.find_neighbours(vec, minx, miny)
        if vec.nil?
            # On empty vector, just return an empty neighbour
            return {}
        end

        x = vec[:x]
        y = vec[:y]

        neighbours = []

        # Add adjacent cells to neighbour list
        (-1..1).each do |i|
            new_x = x + i
            # Ensure x in range
            if new_x >= minx[:min] && new_x < minx[:max]
                (-1..1).each do |j|

                    new_y = y + j
                    # Ensure y in range
                    if new_y >= miny[:min] && new_y < miny[:max]
                        # Check for diagonals
                        if ((i + j) % 2) != 0 && i != j 
                            neighbours.push( { :x => new_x, :y => new_y } )       
                        end
                    end
                end
            end
        end

        neighbours
    end

    def draw_relative(x, y)
        @map.each do |tile| 
            tile.draw_relative(x, y)
        end
    end

    # Find a location on the island to put a dock
    def make_dock

        lowest = @land.first
        @land.each do |tile|
            if more_south(tile, lowest)
                lowest = tile
            end
        end

        Dock.create(:x => lowest[:x] * @width, :y => (lowest[:y]+ 1) * @height )
    end

    # Check if tile2 is more south than tile 1
    def more_south(tile1, tile2)
        return tile1[:y] > tile2[:y]
    end
end
