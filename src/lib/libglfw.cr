@[Link("glfw3")]
lib LibGLFW
  type Window = Void*
  type Monitor = Void*

  fun init = glfwInit() : Int32
  fun window_hint = glfwWindowHint(target : Int32, hint : Int32) : Void
  fun terminate = glfwTerminate() : Void

  fun create_window = glfwCreateWindow(width : Int32, height : Int32, title : UInt8*, 
                                       monitor : Monitor, share : Window) : Window
  fun set_current_context = glfwMakeContextCurrent(window : Window) : Void
  fun get_current_context = glfwGetCurrentContext() : Window

  fun set_input_mode = glfwSetInputMode(window : Window, mode : Int32, 
                                        value : Int32) : Void
  fun swap_buffers = glfwSwapBuffers(window : Window) : Void
  fun poll_events = glfwPollEvents() : Void
  fun get_key = glfwGetKey(window : Window, key : Int32) : Int32
  fun window_should_close = glfwWindowShouldClose(window : Window) : Int32

  fun get_cursor_pos = glfwGetCursorPos(window : Window, xpos : Float64*, 
                                        ypos : Float64*) : Void
  fun set_cursor_pos = glfwSetCursorPos(window : Window, xpos : Float64, 
                                        ypos : Float64) : Void

  fun get_time = glfwGetTime() : Float64
end
