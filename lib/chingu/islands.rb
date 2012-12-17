require "chingu"

# Helped Methods to Combine all the Islands into one map
class Islands < GameObjectMap

    def initialize(options = {})
        super(options)
    end

    def add_map(map)
        @map += map.map
    end

    def draw
        @map.each do |tile| 
            tile.draw
        end
    end

    def occupied?(game_object)
        occupado = false

        @map.each do |tile|
             if game_object.collides? tile
                 occupado = true
             end
        end
        occupado
    end

    def draw_relative(x, y)
        @map.each do |tile| 
            if tile.paused?
                puts "Paused"
            end
            tile.draw_relative(x, y)
        end
    end
end
