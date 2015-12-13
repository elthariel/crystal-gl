require "../utils/macros"
require "../lib/libgl"
require "./version"
require "./const"

macro gl_checked(call)
  value = {{call}}
  raise "OpenGL call failed: " + {{call.stringify}} if GL::C.get_error != GL::NO_ERROR
  value
end

module GL
  module C
    import_fun(LibGL, get_error, get_string, get_stringi,
               clear_color, clear, enable, disable, depth_func,
               bind_vertex_array,
               bind_buffer, buffer_data,
               enable_vertex_attrib_array, disable_vertex_attrib_array,
               vertex_attrib_pointer, draw_arrays,
               bind_texture, tex_image_2d,
               tex_parameteri, generate_mipmap,
               create_shader, shader_source, compile_shader, delete_shader,
               get_shader_info_log,
               create_program, attach_shader, link_program,
               get_program_info_log,
               use_program, get_uniform_location, uniform_matrix_4fv)

    import_fun_out(LibGL, get_integerv, false, false, {pname: false, value: true})
    import_fun_out(LibGL, get_integer64v, false, false, {pname: false, value: true})
    import_fun_out(LibGL, get_booleanv, false, false, {pname: false, value: true})
    import_fun_out(LibGL, get_floatv, false, false, {pname: false, value: true})
    import_fun_out(LibGL, get_doublev, false, false, {pname: false, value: true})

    import_fun_out(LibGL, get_integeri_v, false, false,
                   {pname: false, index: false, value: true})
    import_fun_out(LibGL, get_integer64i_v, false, false,
                   {pname: false, index: false, value: true})
    import_fun_out(LibGL, get_booleani_v, false, false,
                   {pname: false, index: false, value: true})
    import_fun_out(LibGL, get_floati_v, false, false,
                   {pname: false, index: false, value: true})
    import_fun_out(LibGL, get_doublei_v, false, false,
                   {pname: false, index: false, value: true})
    import_fun_bool(LibGL, is_enabled?)

    import_fun_out(LibGL, gen_vertex_arrays, false, false, {n: false, ids: true})
    import_fun_out(LibGL, gen_buffers, false, false, {n: false, ids: true})
    import_fun_out(LibGL, gen_textures, false, false, {n: false, textures: true})
    import_fun_out(LibGL, get_shader_iv, false, false,
                   {shader: false, key: false, value: true})
    import_fun_out(LibGL, get_program_iv, false, false,
                   {program: false, key: false, value: true})
  end

  def self.last_error
    @@last_error = GL::C.get_error
    @@last_error = nil if @@last_error == GL::NO_ERROR
    @@last_error
  end

  def self.last_error_message
    case @@last_error
    when nil
      nil
    when GL::NO_ERROR
      nil
    when GL::INVALID_ENUM
      "INVALID_ENUM"
    when GL::INVALID_VALUE
      "INVALID_VALUE"
    when GL::INVALID_OPERATION
      "INVALID_OPERATION"
    when GL::STACK_OVERFLOW
      "STACK_OVERFLOW"
    when GL::STACK_UNDERFLOW
      "STACK_UNDERFLOW"
    when GL::OUT_OF_MEMORY
      "OUT_OF_MEMORY"
    else
      "UNKNOWN"
    end
  end

  def self.version
    GL::Version.get
  end

  def self.extensions
    n = GL::C.get_integerv(GL::NUM_EXTENSIONS)
    extensions = [] of String
    0.upto(n - 1) do |i|
      extensions << String.new(GL::C.get_stringi(GL::EXTENSIONS, i.to_u32))
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
    GL::C.clear_color red.to_f32, green.to_f32, blue.to_f32, alpha.to_f32
  end

  def self.clear
    GL::C.clear GL::COLOR_BUFFER_BIT
  end

  def self.to_boolean(value)
    if value
      GL::TRUE
    else
      GL::FALSE
    end
  end
end
