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
    end

    def generate size
        x_start = rand($window.width/@width)
        y_start = rand($window.height/@height)

        land = []
        land.push( { :x => x_start, :y => y_start } )

        border_x = {:min => 0, :max => $window.width}
        border_y = { :min => 0, :max => $window.height }

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

    def draw
    end
end
