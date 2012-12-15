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
    def crossProduct!(v_cross)

        @x = (@x * v_cross.x) + (@x * v_cross.y)
        @y = (@y * v_cross.x) + (@y * v_cross.y)
        self
    end

    # Multiple components together to get a new vector
    def crossProduct(v_cross)
        vec = copy
        vec.crossProduct!(v_cross)
    end

    # Calculate the modulus of the vector, or length
    def length
        modulo = sqrt( @x ** 2 + @y ** 2)
    end

    # Rotate a vector by angle (degrees)
    def rotate!(angle)
        rotationVector = Vector.new(cos(angle), sin(angle))
        rotationVector.crossProduct! Vector.new( -sin(angle), cos(angle) )

        rotationVector.crossProduct!(self)

        @x = rotationVector
        @y = rotationVector

        rotationVector
    end

    # Rotate a vector by angle (degrees)
    def rotate(angle)
        vec = copy
        vec.rotate!(angle)
    end

    # Change vector to a form with no length
    def normalise!

        # Avoid division by zero
        if @x != 0 
            @x /= length
        end

        if @y != 0
            @y /= length
        end

        self 
    end

    def normalise
        vec = copy
        vec.normalise!
    end

    def +(vec)
        x = @x + vec.x
        y = @y + vec.y

        vec = Vector.new(x, y)
    end

    def -(vec)
        x = @x - vec.x
        y = @y - vec.y

        vec = Vector.new(x, y)
    end

    def *(scalar)
        x = @x * scalar
        y = @y * scalar

        vec = Vector.new(x, y)
    end

    # Divide all components by scalar
    def /(scalar)
        x = @x / scalar
        y = @y / scalar

        vec = Vector.new(x, y)
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
