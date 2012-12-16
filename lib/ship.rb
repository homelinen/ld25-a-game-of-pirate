class Ship < Chingu::GameObject
    trait :velocity
#    traits :collision_detection, :bounding_box

    def initialize(options = {})
        super(options)

        self.max_velocity = 5
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

    def fire fire_angle
        max_velocity = 10

        velocity_x = Gosu::offset_x(self.angle + fire_angle, 0.5)*max_velocity
        velocity_y = Gosu::offset_y(self.angle + fire_angle, 0.5)*max_velocity

        offset_x = Gosu::offset_x(self.angle + fire_angle, self.width/2 + 9)
        offset_y = Gosu::offset_y(self.angle + fire_angle, self.height/2 + 9)

        # Create a bullet object on either bow or stern
        bullet = Bullet.create(
                :x => @x + offset_x,
                :y => @y + offset_y,
                :velocity_x => velocity_x,
                :velocity_y => velocity_y,
                :max_velocity => max_velocity
        )
    end

end
