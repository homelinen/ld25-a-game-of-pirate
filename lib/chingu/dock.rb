require "chingu"

# Dock for ships, where you can take prisoners
class Dock < Chingu::GameObject

    trait :bounding_box

    def initialize(options = {})
        super(options.merge(:image => Image["dock.png"]))

        @villagers = 0
        @villager_worth = 2
    end

    def villagers?
        @villagers > 0
    end

    def clear!
        villagers = @villagers
        @villagers = 0

        villagers
    end

    # Add villagers to pop and give back gold worth
    def sell v_count

        # Check if a slaver dock
        if !@villager_worth.nil?
            @villagers += v_count

            v_count * @villager_worth
        end
    end
end
