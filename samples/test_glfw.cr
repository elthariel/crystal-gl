require "../src/all"
require "./scene"

class TestApp < GLFW::App
  def self.input_modes
    {
      GLFW::STICKY_KEYS => GL::TRUE,
      GLFW::CURSOR => GLFW::CURSOR_DISABLED,
    }
  end

  def initialize
    super

    @speed = 3_f32
    @mouse_speed = 0.05_f32

    @scene = Scene.new
    @scene.setup

    @last_xpos, @last_ypos = GLFW::C.get_cursor_pos @window
  end

  def process_inputs(delta_time)
    # process cursor position
    xpos, ypos = GLFW::C.get_cursor_pos @window

    @scene.horizontal_angle += @mouse_speed * delta_time * (@last_xpos - xpos)
    @scene.vertical_angle += @mouse_speed * delta_time * (@last_ypos - ypos)

    @last_xpos = xpos
    @last_ypos = ypos

    # process keys
    if get_key(GLFW::KEY_W) == GLFW::PRESS
      @scene.position += @scene.direction * delta_time * @speed
    end
    if get_key(GLFW::KEY_S) == GLFW::PRESS
      @scene.position -= @scene.direction * delta_time * @speed
    end
    if get_key(GLFW::KEY_A) == GLFW::PRESS
      @scene.position -= @scene.right * delta_time * @speed
    end
    if get_key(GLFW::KEY_D) == GLFW::PRESS
      @scene.position += @scene.right * delta_time * @speed
    end
  end

  def render_frame(delta_time)
    @scene.render
  end

  def cleanup
    @scene.cleanup
  end
end

begin
  TestApp.new.run
rescue ex
  puts "FATAL ERROR: #{ex}"
end
