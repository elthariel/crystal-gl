require "./glfw"
require "../glew"
require "../gl"

module GLFW
  class App
    def self.window_hints
      {
        GLFW::SAMPLES => 4,
        GLFW::CONTEXT_VERSION_MAJOR => 3,
        GLFW::CONTEXT_VERSION_MINOR => 3,
        GLFW::OPENGL_FORWARD_COMPAT => 1,
        GLFW::OPENGL_PROFILE => GLFW::OPENGL_CORE_PROFILE,
      }
    end

    def self.input_modes
      { GLFW::STICKY_KEYS => GL::TRUE }
    end

    def initialize(@title = "Crystal OpenGL", @width = 1024, @height = 768)
      unless GLFW.init
        raise "Failed to initialize GLFW"
      end

      self.class.window_hints.each do |hint, value|
        GLFW::C.window_hint hint, value
      end

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

      self.class.input_modes.each do |key, value|
        GLFW::C.set_input_mode @window, key, value
      end

      puts "OpenGL version: " + GL.version.to_s
      puts "OpenGL extensions: " + GL.extensions.join(", ")
      puts GL::Caps.disable_dither!
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
