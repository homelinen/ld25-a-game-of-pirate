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
        :up => :move_forward,
        :space => :fire
    }
  end    
end

class Player < Chingu::GameObject

    def initialize(options = {})
        super(options.merge( :image => Image["pirateShip.png"] ))

        # Duplication in data, sadly
        @vector = Vector.new(@x, @y)
    end

    def move_forward
       # Move in the vector you are pointing 
       temp_vector = Vector.new(1, @y).normalise 
       temp_vector.rotate! 90

       puts temp_vector
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
