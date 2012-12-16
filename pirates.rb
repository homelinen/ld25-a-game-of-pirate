require "chingu"

Dir["#{File.dirname(__FILE__)}/lib/*.rb"].each {|f| require f}
include Gosu
include Chingu

class Game < Chingu::Window
  def initialize
    super(800, 600, false)
  end    

  def setup
      retrofy
      self.factor = 1
      switch_game_state(Pirates.new)
  end
end

class Pirates < GameState
    trait :viewport
    def initialize(options = {})
        super
        self.viewport.lag = 0
        self.viewport.game_area = [0, 0, 500, 500]

        @player = Player.create(:x => $window.width/2, :y => $window.height/2)
        @player.input = {
            :holding_left => :steer_left, 
            :holding_right => :steer_right,
            :holding_up => :move_forward,
            :space => :fire_cannon
        }

        @sea = Sea.create

        @islands = []

        min_size = 5
        for i in (0..5) do
            @islands.push Island.new(:game_objects => {}, :island_size => min_size + rand(25))
        end

        @galleon = Galleon.create(:x => rand($window.width), :y => rand($window.height))
    end

    def update
        super
        self.viewport.center_around(@player)

        # Collisions
        Galleon.each_collision(Bullet) do |galleon, bullet|
            galleon.destroy
            bullet.destroy
        end
    end

    def draw
        @viewport.apply { super  }
        self.game_objects.draw_relative(-@viewport.x, -@viewport.y)
        for i in (0..$window.width/@sea.width) do
            for j in (0..$window.height/@sea.height) do
                @sea.x = i * @sea.width
                @sea.y = j * @sea.height
                @sea.draw
            end
        end

        game_objects_of_class(Grass).each do |grass_tile|
            grass_tile.draw
        end

        game_objects_of_class(Bullet).each do |cannon_ball|
            cannon_ball.draw
        end

        @islands.each do |island|
            island.draw
        end

        @player.draw

        # Enemy
        @galleon.draw
    end
end

# Start the Game
Game.new.show
