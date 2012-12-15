require "chingu"

include Gosu
include Chingu

require_relative "vector.rb"

class Game < Chingu::Window
  def initialize
    super
    @player = Player.create 
    @player.input = {
        :holding_left => :steer_left, 
        :holding_right => :steer_right,
        :holding_up => :move_forward,
        :space => :fire
    }

    @sea = Sea.create
  end    

  def draw
    for i in (0..width/@sea.width) do
        for j in (0..height/@sea.width) do
            @sea.x = i * @sea.width
            @sea.y = j * @sea.height
            @sea.draw
        end
    end
    @player.draw
  end
end

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

class Sea < Chingu::GameObject
    trait :animation, :delay => 200, :size => [64,64]

    def initialize(options = {})
        super(options.merge(:image => Image["sea.png"]))
    end

    def update
        @image = self.animation.next if self.animation
    end
end

# An area impassable to ships
# Other things can be built onto it
class Island < Chingu::GameObject
    def initialize(options)

    end
end

# Start the Game
Game.new.show
