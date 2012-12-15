class Player < Chingu::GameObject
    trait :velocity

    def initialize(options = {})
        super(options.merge( :image => Image["pirateShip.png"] ))

        @x = 300
        @y = 300

        self.max_velocity = 2
    end

   # Move in the vector you are pointing 
    def move_forward
        self.velocity_x = Gosu::offset_x(self.angle, 0.5)*self.max_velocity_x
        self.velocity_y = Gosu::offset_y(self.angle, 0.5)*self.max_velocity_y
    end

    def update
        self.velocity_x *= 0.95
        self.velocity_y *= 0.95
    end

    def steer_right
        @angle += 2
    end

    def steer_left
        @angle -= 2
    end

    def fire
        # Create a bullet object on either bow or stern
    end

end
