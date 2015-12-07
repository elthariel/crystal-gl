require "./glfw"
require "../glew"
require "../gl"

module GLFW
  class App
    def initialize(@title = "Crystal OpenGL", @width = 1024, @height = 768)
      unless GLFW.init
        raise "Failed to initialize GLFW"
      end

      GLFW::C.window_hint GLFW::SAMPLES, 4
      GLFW::C.window_hint GLFW::CONTEXT_VERSION_MAJOR, 3
      GLFW::C.window_hint GLFW::CONTEXT_VERSION_MINOR, 3
      GLFW::C.window_hint GLFW::OPENGL_FORWARD_COMPAT, 1
      GLFW::C.window_hint GLFW::OPENGL_PROFILE, GLFW::OPENGL_CORE_PROFILE

      @window = GLFW::C.create_window @width, @height, @title, nil, nil

      raise "Failed to open GLFW window" if @window.nil?

      GLFW::C.set_current_context @window

      ifdef not darwin
        GLEW.experimental = GL::TRUE
        unless GLEW.init == GLEW::OK
          raise "Failed to initialize GLEW"
        end
        check_error "after GLEW initialization (ignore on OSX)"
      end

      GLFW::C.set_input_mode @window, GLFW::STICKY_KEYS, 1
      GLFW::C.set_input_mode @window, GLFW::CURSOR, GLFW::CURSOR_DISABLED

      puts "OpenGL version: " + GL.version
      puts "OpenGL extensions: " + GL.extensions.join(", ")
    end

    def get_key(key)
      GLFW::C.get_key(@window, key)
    end

    def get_time
      GLFW::C.get_time
    end

    def should_close?
      GLFW::C.window_should_close(@window)
    end

    def stop_rendering?
      get_key(GLFW::KEY_ESCAPE) == GLFW::PRESS || should_close?
    end

    def run
      frames = 0
      start = last_time = GLFW::C.get_time

      while true
        GLFW::C.poll_events

        break if stop_rendering?

        current_time = get_time
        delta_time = current_time - last_time

        process_inputs delta_time
        render_frame delta_time

        frames += 1
        last_time = current_time

        # Swap buffers and do the GLFW events bookkeeping
        GLFW::C.swap_buffers @window
      end

      delta_t = get_time - start
      puts "#{frames} in #{delta_t} secs"
      puts "FPS: #{frames / delta_t}"

      terminate
    end

    def terminate
      cleanup
      GLFW::C.terminate
    end

    abstract def process_inputs
    abstract def render_frame
    abstract def cleanup
  end
end
