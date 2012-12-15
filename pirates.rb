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
  end    
end

class Player < Chingu::GameObject

    def initialize(options = {})
        super(options.merge( :image => Image["pirateShip.png"] ))

        @x = 300
        @y = 300

        # Duplication in data, sadly
        @vector = Vector.new(@x, @y)
        @cur_vector = Vector.new(1.0, 0.0).normalise 
    end

   # Move in the vector you are pointing 
    def move_forward
        speed = 4
        new_vec = (@cur_vector.rotate angle.abs) * speed
        
        @x += new_vec.x
        @y += new_vec.y

        @cur_vector = new_vec.normalise 
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

# An area impassable to ships
# Other things can be built onto it
class Island < Chingu::GameObject
    def initialize(options)

    end
end

# Start the Game
Game.new.show
