require "../utils/macros"
require "../gl/gl"
require "../lib/libglew"

module GLEW
  module C
    import_fun(LibGLEW, glewInit)
  end

  def self.init
    C.glewInit
  end

  def self.experimental(enable)
    LibGLEW.experimental = GL.to_tool(enable)
  end
end
