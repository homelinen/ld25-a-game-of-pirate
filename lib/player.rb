require_relative "ship"

class Player < Ship
    trait :velocity

    def initialize(options = {})
        super(options.merge( :image => Image["pirateShip.png"] ))

        @x = 300
        @y = 300

        self.max_velocity = 2
    end
end
