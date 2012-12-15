require "chingu"
include Gosu
include Chingu

class Game < Chingu::Window
  def initialize
    super
    @player = Player.create 
    @player.input = {
        :left => :steer_left, 
        :right => :steer_right,
        :space => :fire
    }
  end    
end

class Player < Chingu::GameObject

    def initialize(options = {})
        super(options.merge( :image => Image["pirateShip.png"] ))
    end

    def move_forward
       # Move in the vector you are pointing 
        
    end

    def steer_right
        @angle += 1
    end

    def steer_left
        @angle -= 1
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
