class Sea < Chingu::GameObject
    trait :animation, :delay => 200, :size => [64,64], :bounce => true

    def initialize(options = {})
        super(options.merge(:image => Image["sea.png"]))
    end

    def update
        @image = self.animation.next if self.animation
    end
end
