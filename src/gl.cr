require "./lib/*"
require "./gl/*"

macro gl_checked(call)
  value = {{call}}
  raise "OpenGL call failed: " + {{call.stringify}} if LibGL.get_error != LibGL::NO_ERROR
  value
end

module GL
  def self.last_error
    @@last_error = LibGL.get_error
    @@last_error = nil if @@last_error == LibGL::NO_ERROR
    @@last_error
  end

  def self.last_error_message
    case @@last_error
    when nil
      nil
    when LibGL::NO_ERROR
      nil
    when LibGL::INVALID_ENUM
      "INVALID_ENUM"
    when LibGL::INVALID_VALUE
      "INVALID_VALUE"
    when LibGL::INVALID_OPERATION
      "INVALID_OPERATION"
    when LibGL::STACK_OVERFLOW
      "STACK_OVERFLOW"
    when LibGL::STACK_UNDERFLOW
      "STACK_UNDERFLOW"
    when LibGL::OUT_OF_MEMORY
      "OUT_OF_MEMORY"
    else
      "UNKNOWN"
    end
  end

  def self.version
    String.new(LibGL.get_string(LibGL::VERSION))
  end

  def self.extensions
    LibGL.get_integerv(LibGL::NUM_EXTENSIONS, out n)
    extensions = [] of String
    0.upto(n - 1) do |i|
      extensions << String.new(LibGL.get_stringi(LibGL::EXTENSIONS, i.to_u32))
    end
    extensions
  end

  def self.clear_color color
    case color.size
    when 4
      clear_color color[0], color[1], color[2], color[3]
    when 3
      clear_color color[0], color[1], color[2], 0
    else
      raise "Invalid color specified. Needs 3 or 4 values"
    end
  end

  def self.clear_color red, green, blue, alpha
    LibGL.clear_color red.to_f32, green.to_f32, blue.to_f32, alpha.to_f32
  end

  def self.clear
    LibGL.clear LibGL::COLOR_BUFFER_BIT
  end

  def self.to_boolean(value)
    if value
      LibGL::TRUE
    else
      LibGL::FALSE
    end
  end
end
