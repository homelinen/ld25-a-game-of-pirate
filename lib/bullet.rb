class Bullet < Chingu::GameObject
    traits :velocity, :bounding_circle
    trait :animation, :delay => 200, :size => [16,16]

    def initialize(options = {})
        super(options.merge(:image => Image["cannon-ball.png"]))
    end

    def update
        @image = self.animation.next if self.animation

        if (@x < 0 || @x > $window.width) ||
            (@y < 0 || @y > $window.height)
            self.destroy
        end
    end
end
