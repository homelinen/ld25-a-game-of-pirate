require "chingu"

class IslandTile < Chingu::GameObject
    trait :bounding_box

    def initialize(options = {})
        super options
    end
end

# Consider using a module
class Grass < IslandTile
    trait :bounding_box

    def initialize(options = {})
        super options
    end
end

class House < IslandTile
    trait :animation
    trait :bounding_box
    
    def initialize(options = {})
        super(options)

        @resident_count = options[:resident_count]
    end

    def update
        @image = self.animate.next if self.animation
    end
end

class Beach < IslandTile
    trait :bounding_box

    def initialize(options = {})
        super(options)
    end
end
