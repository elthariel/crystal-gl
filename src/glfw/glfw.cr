require "../utils/macros"
require "../lib/libglfw"
require "./const"

module GLFW
  module C
    import_fun(LibGLFW, init, window_hint, terminate, create_window, set_current_context,
               get_current_context, set_input_mode, swap_buffers, poll_events, get_key,
               window_should_close, set_cursor_pos, get_time)

    import_fun_out(LibGLFW, get_cursor_pos, true, false, {window: false, xpos: true, ypos: true})
  end

  def self.init
    C.init
  end
end
