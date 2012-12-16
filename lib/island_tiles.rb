require "chingu"

# Consider using a module
class Grass < Chingu::GameObject
    def initialize(options = {})
        super options
    end
end

class House < GameObject
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

class Beach < Chingu::GameObject
    trait :bounding_box

    def initialize(options = {})
        super(options)
    end
end
