require "chingu"

class IslandTile < Chingu::GameObject
    traits :bounding_circle, :collision_detection

    def initialize(options = {})
        super options
        cache_bounding_circle
    end
end

# Consider using a module
class Grass < IslandTile

    def initialize(options = {})
        super options
    end
end

class House < IslandTile
    trait :animation, :size => 32
    
    def initialize(options = {})
        super(options.merge(:image => Image["house_32x32.png"]))

        @resident_count = options[:resident_count]
    end

    def capture
        count = @resident_count
        @resident_count = 0
        count
    end

    def update
        @image = self.animation.next if self.animation
    end
end

class Beach < IslandTile

    def initialize(options = {})
        super(options)
    end
end
