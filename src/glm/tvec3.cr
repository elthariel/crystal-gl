module GLM
  struct TVec3(T)
    @buffer :: T*

    def self.zero
      new T.zero, T.zero, T.zero
    end

    def initialize(x, y, z)
      @buffer = Pointer(T).malloc(3)
      @buffer[0] = x
      @buffer[1] = y
      @buffer[2] = z
    end

    def [](i : Int32)
      raise IndexError.new if i >= 3 || i < 0
      @buffer[i]
    end

    def []=(i : Int32, value)
      raise IndexError.new if i >= 3 || i < 0
      @buffer[i] = value
    end

    def x
      @buffer[0]
    end

    def x=(value)
      @buffer[0] = value
    end

    def y
      @buffer[1]
    end

    def y=(value)
      @buffer[1] = value
    end

    def z
      @buffer[2]
    end

    def z=(value)
      @buffer[2] = value
    end

    def +(v : TVec3(T))
      TVec3(T).new(x + v.x, y + v.y, z + v.z)
    end

    def -(v : TVec3(T))
      TVec3(T).new(x - v.x, y - v.y, z - v.z)
    end

    def *(a)
      TVec3(T).new(x * a, y * a, z * a)
    end

    def /(a)
      TVec3(T).new(x / a, y / a, z / a)
    end

    def length
      Math.sqrt(x * x + y * y + z * z)
    end

    def normalize
      self / length
    end

    def cross(v : TVec3(T))
      TVec3(T).new(y * v.z - v.y * z,
                   z * v.x - v.z * x,
                   x * v.y - v.x * y)
    end

    def dot(v : TVec3(T))
      x * v.x + y * v.y + z * v.z
    end
  end
end
