require "chingu"

class Beach < Chingu::GameObject
    trait :bounding_box

    def initialize(options = {})
        super(options)
    end
end
