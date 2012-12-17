require_relative "ship"

class Player < Ship
    trait :velocity
    traits :bounding_box, :collision_detection

    def initialize(options = {})
        super(options.merge( :image => Image["pirateShip.png"] ))

        @last_fired = "right"

        self.max_velocity = 5
    end

    def fire_cannon
        
        if @last_fired == "right"
            fire(-90)
            @last_fired = "left"
        else
            fire(90)
            @last_fired = "right"
        end
    end
end
