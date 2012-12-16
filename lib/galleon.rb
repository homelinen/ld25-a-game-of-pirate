require_relative "ship"

class Galleon < Ship

    traits :collision_detection, :bounding_box
    
    def initialize(options = {})
        super(options.merge(:image => Image["galleon.png"]))
    end

    def update

        # plot course

        if (@x >= 0 && @x < $window.width) && (@y >= 0 && @y < $window.height)
            # Flip a coin
            direction = rand(10)

            # Randomly pick  a new direction, with a small chance of success
            if direction == 6
                @angle -= 5
            elsif direction == 3
                @angle += 5
            end
        else
            # Turn around
            @angle += 180
        end

        if rand(200) == 0
            if rand(11) > 5
                fire(90)
            else
                fire(-90)
            end
        end

        move_forward
        
        # If see enemy, engage
    end

end
