require "../utils/macros"
require "../lib/libglfw"
require "./const"

module GLFW
  module C
    import_fun(LibGLFW, init, window_hint, terminate, create_window, set_current_context,
               get_current_context, set_input_mode, swap_buffers, swap_interval,
               poll_events, get_key, set_cursor_pos, get_time)

    import_fun_out(LibGLFW, get_cursor_pos, true, false, {window: false, xpos: true, ypos: true})

    def self.window_should_close(window)
      LibGLFW.window_should_close(window) != 0
    end
  end

  def self.init
    C.init
  end
end
