require "../src/all"
require "./models/cube"

class Scene
  property! :position
  property! :horizontal_angle
  property! :vertical_angle
  property! :fov

  def initialize
    @background_color = [0, 0, 0.4]

    @vertex_array_id = gl_checked GL::C.gen_vertex_arrays 1

    @vertex_buffer = GL::C.gen_buffers 1
    @uv_buffer = GL::C.gen_buffers 1

    @program = load_shaders
    @model = Cube.new

    @texture = load_texture

    @position = GLM.vec3(0,0,5)
    @horizontal_angle = 3.14_f32
    @vertical_angle = 0_f32
    @fov = 45_f32
    @scene_ratio = 4.0/3.0
  end

  def root
    File.dirname(__FILE__)
  end

  def direction
    GLM.vec3(Math.cos(@vertical_angle) * Math.sin(@horizontal_angle),
             Math.sin(@vertical_angle),
             Math.cos(@vertical_angle) * Math.cos(@horizontal_angle))
  end

  def right
    GLM.vec3(Math.sin(@horizontal_angle - Math::PI / 2),
             0,
             Math.cos(@horizontal_angle - Math::PI / 2))
  end

  def mvp
    dir = direction
    up = right.cross(dir)

    # Setup ModelViewProjection matrix
    projection = GLM.perspective @fov, @scene_ratio, 0.1, 100.0
    view = GLM.look_at @position, @position + dir, up
    model = GLM::Mat4.identity
    projection * view * model
  end

  def setup
    # Bind the VAO (vertex array object)
    gl_checked GL::C.bind_vertex_array @vertex_array_id

    # Bind and set the VBO (vertex buffer object) data
    GL::C.bind_buffer GL::ARRAY_BUFFER, @vertex_buffer
    GL::C.buffer_data GL::ARRAY_BUFFER, @model.vertices.size * sizeof(Float32), (@model.vertices.buffer as Void*), GL::STATIC_DRAW

    # Load the UV data into the uv_buffer
    GL::C.bind_buffer GL::ARRAY_BUFFER, @uv_buffer
    GL::C.buffer_data GL::ARRAY_BUFFER, @model.uv.size * sizeof(Float32), (@model.uv.buffer as Void*), GL::STATIC_DRAW

    # Enable and configure the attribute 0 for each vertex position
    GL::C.enable_vertex_attrib_array 0_u32
    GL::C.bind_buffer GL::ARRAY_BUFFER, @vertex_buffer
    GL::C.vertex_attrib_pointer 0_u32, 3, GL::FLOAT, GL::FALSE, 0, nil

    # Enable and configure the attribute 1 for each uv coordinate
    GL::C.enable_vertex_attrib_array 1_u32
    GL::C.bind_buffer GL::ARRAY_BUFFER, @uv_buffer
    gl_checked GL::C.vertex_attrib_pointer 1_u32, 2, GL::FLOAT, GL::FALSE, 0, nil

    GL::C.enable GL::DEPTH_TEST
    GL::C.depth_func GL::LESS
  end

  def render
    # Clear the scene
    GL.clear_color @background_color
    GL::C.clear GL::COLOR_BUFFER_BIT | GL::DEPTH_BUFFER_BIT

    # Use the shader program
    @program.use

    # Send the matrix to the shader program
    gl_checked @program.set_uniform_matrix_4f "MVP", false, mvp

    # Draw the vertices
    gl_checked GL::C.draw_arrays GL::TRIANGLES, 0, @model.vertices.size
  end

  def cleanup
    # Disable the shader program attribute
    GL::C.disable_vertex_attrib_array 0_u32
  end

  def load_shaders
    GL::ShaderProgram.simple("#{root}/shaders/vertex_shader.glsl",
                             "#{root}/shaders/fragment_shader.glsl")
  end

  def load_texture
    image_data, width, height, channels = SOIL::C.load_image("#{root}/textures/crystal.png",
                                                             SOIL::LOAD_RGB)
    tex_id = GL::C.gen_textures 1
    GL::C.bind_texture GL::TEXTURE_2D, tex_id
    GL::C.tex_image_2d GL::TEXTURE_2D, 0, GL::RGB, width, height, 0, GL::RGB, GL::UNSIGNED_BYTE, image_data as Void*
    GL::C.tex_parameteri GL::TEXTURE_2D, GL::TEXTURE_MAG_FILTER, GL::LINEAR
    GL::C.tex_parameteri GL::TEXTURE_2D, GL::TEXTURE_MIN_FILTER, GL::LINEAR_MIPMAP_LINEAR
    GL::C.generate_mipmap GL::TEXTURE_2D
    SOIL::C.free_image_data image_data

    SOIL::C.load_texture("textures/crystal.png",
                         SOIL::LOAD_AUTO,
                         SOIL::CREATE_NEW_ID,
                         0_u32)

    puts "Loaded texture #{tex_id}"

    tex_id
  end
end
