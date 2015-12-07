require "./libgl"

@[Link("glew")]
lib LibGLEW
  $experimental = glewExperimental : GL::Boolean

  fun init = glewInit() : Int32
end

