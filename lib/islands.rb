require "chingu"

# Helped Methods to Combine all the Islands into one map
class Islands < GameObjectMap

    def initialize(options = {})
        super(options)
    end

    def add_map(map)
        @map += map.map
    end

    def draw_relative(x, y)
        @map.each do |tile| 
            tile.draw_relative(x, y)
        end
    end
end
