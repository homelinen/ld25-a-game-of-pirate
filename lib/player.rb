require_relative "ship"

class Player < Ship
    trait :velocity

    def initialize(options = {})
        super(options.merge( :image => Image["pirateShip.png"] ))

        @x = 300
        @y = 300

        @last_fired = "right"

        self.max_velocity = 2
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
