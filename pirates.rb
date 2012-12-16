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
    def initialize(options = {})
        super

        @player = Player.create(:x => 500, :y => 500)
        @player.input = {
            :holding_left => :steer_left, 
            :holding_right => :steer_right,
            :holding_up => :move_forward,
            :space => :fire_cannon
        }

        @deaths = 0

        @sea = Sea.create(:zorder => 10)

        @islands = Islands.new(:game_objects => {})

        min_size = 5
        for i in (0..5) do
            @islands.add_map(Island.new(:game_objects => {}, :island_size => min_size + rand(25)))
        end

        @galleon = Galleon.create(
            :x => rand($window.width),
            :y => rand($window.height),
            :max_velocity => 10
        )
        while (@islands.occupied?(@galleon))
            @galleon = Galleon.create(
                :x => rand($window.width),
                :y => rand($window.height),
                :max_velocity => 10
            )
        end

    end

    def update
        super

        # Collisions
        Galleon.each_collision(Bullet) do |galleon, bullet|
            galleon.destroy
            bullet.destroy
        end

        @bullets = []
        game_objects.each do |object|
            @bullets.push object if object.is_a? Bullet
        end

        @bullets.each do |bullet|

            if ! @galleon.nil? && @galleon.collides?(bullet)
                p "Hit"
                @galleon.destroy
                @galleon = nil
                bullet.destroy
            end

            if @player.collides? bullet
                puts "YOU WERE STRUCK!"
            end
        end

        @islands.map.each do |object|
            if object.is_a? IslandTile

                if @player.collides?(object)
                    @deaths += 1

                    puts @deaths
                elsif !@galleon.nil? && @galleon.collides?(object)

                    @galleon.reverse 
                end
            end
        end
    end

    def draw
        border_x = {:min => 0, :max => $window.width }
        border_y = { :min => 0, :max => $window.height }

        for i in (0..($window.width/@sea.width + 1)) do
            for j in (0..($window.height/@sea.height + 1)) do
                @sea.x = i * @sea.width
                @sea.y = j * @sea.height
                @sea.draw
            end
        end

        game_objects_of_class(Bullet).each do |cannon_ball|
            cannon_ball.draw
        end

        @islands.draw

        @player.draw

        # Enemy
        @galleon.draw if !@galleon.nil?
    end
end

# Start the Game
Game.new.show
