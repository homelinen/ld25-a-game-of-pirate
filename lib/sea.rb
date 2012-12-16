class Sea < Chingu::GameObject
    trait :animation, :delay => 200 

    def initialize(options = {})
        super(options.merge(:image => Image["sea.png"]))
    end

    def update
        @image = self.animation.next if self.animation
    end
end
