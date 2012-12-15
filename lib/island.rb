require_relative "island_tiles"

# An area impassable to ships
# Other things can be built onto it
class Island < GameObjectMap 
    def initialize(options = {})
        super(options)
        @width = @grid[0]
        @height = @grid[1]
        generate

        # Create the drawable objects
        @land.each do |point|
            Grass.create(
                  :image => Image["grass.png"],
                  :x => point[:x] * @grid[0],
                  :y => point[:y] * @grid[1]
            )
        end
    end

    def generate
        x_start = rand($window.width/@width)
        y_start = rand($window.height/@height)

        land = []
        land.push( { :x => x_start, :y => y_start } )

        # Consider storing first land as a var
        neighbours = find_neighbours(land.first)

        # Create a 10 tile island
        for i in 0..10 do
            if neighbours.length >= 0
                # Select a random neighbour node
                index = rand(neighbours.length)
                tempNode = neighbours[index] 

                # Remove from list
                neighbours.delete_at index
                
                neighbours += find_neighbours(tempNode)
                land.push tempNode
            end
        end

        @land = land
        @coast = neighbours
    end

    def find_neighbours(vec)
        x = vec[:x]
        y = vec[:y]

        neighbours = []

        # Add adjacent cells to neighbour list
        [-1, 1].each do |i|
            # Ensure x in range
            if x + i >= 0 && x + i < $window.width
                [-1, 1].each do |j|

                    # Ensure y in range
                    if y + i >= 0 && y + i < $window.height
                        # Check for diagonals
                        if ((x + y) % 2) != 0 
                            neighbours.push( { :x => x + i, :y => y + j } )       
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
