include Math

# Simple Vector
class Vector

    def initialize(x = 0, y = 0)
        @x = x
        @y = y
    end

    # Get the dotProduct of v and this
    def dotProduct(v)
        dot = @x * v.x + @y * v.y
    end

    # Multiple components together to get a new vector
    def crossProduct(v2)

        x = (@x * v2.x) + (@x * v2.y)
        y = (@y * v2.y) + (@y * v2.y)

        vec = Vector.new( x, y )
        vec
    end

    # Calculate the modulus of the vector, or length
    def length
        modulo = sqrt( @x ^ 2 + @y ^ 2)
    end

    def rotate(angle)
        rotationVector = Vector.new(cos(angle), sin(angle))
        rotationVector = rotationVector.crossProduct Vector.new( -sin(angle), cos(angle) )

        vec = copy
        vec = vec.crossProduct(rotationVector)

        puts vec
        vec
    end

    def normalize

        # Initialise vars
        vector = Vector.new

        x_new = @x
        y_new = @y

        # Avoid division by zero
        if x_new != 0 && y_new != 0
            x_new /= abs(x_new)
            y_new /= abs(y_new)
        end

        vector.x x_new
        vector.y y_new

        vector
    end

    # Divide all components by scalar
    def /(scalar)
        @x = @x / scalar
        @y = @y / scalar
    end

    # Duplicate vector
    def copy
        vec = Vector.new(@x, @y)
    end

    def to_s
        vec = "Vector (#{@x}, #{@y})"
    end

    def x(x_new = 0)
        if x_new == 0
            return @x
        end

        @x = x_new
    end

    def y(y_new = 0)
        if y_new == 0
            return @y
        end

        @y = y_new
    end

end
