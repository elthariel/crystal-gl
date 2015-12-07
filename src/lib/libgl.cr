module GL
  alias Enum = UInt32     # unsigned int
  alias Boolean = UInt8   # unsigned char
  alias Bitfield = UInt32 # unsigned int
  alias Byte = Int8       # signed char
  alias Short = Int16     # unsigned short
  alias Int = Int32       # int
  alias Int64 = ::Int64   # int
  alias Sizei = Int32     # int
  alias Ubyte = UInt8     # unsigned char
  alias Ushort = UInt16   # unsigned short
  alias Uint = UInt32     # unsigned int
  alias Uint64 = UInt64   # unsigned int
  alias Float = Float32   # float
  alias Double = Float64  # float
  alias Clampf = Float32  # float
  alias Char = UInt8      # char
  alias Sizeiptr = Int32  # long
end

@[Link(framework: "OpenGL")] ifdef darwin
lib LibGL
  # Utility functions
  fun get_error = glGetError() : GL::Enum
  fun glGetGraphicsResetStatus() : GL::Enum

  fun get_string = glGetString(name : GL::Enum) : GL::Ubyte*
  fun get_stringi = glGetStringi(name : GL::Enum, index : GL::Uint) : GL::Ubyte*
  fun get_integerv = glGetIntegerv(pname : GL::Enum, value : GL::Int*) : Void
  fun get_integer64v = glGetInteger64v(pname : GL::Enum, value : GL::Int64*) : Void
  fun get_booleanv = glGetBooleanv(pname : GL::Enum, value : GL::Int*) : Void
  fun get_floatv = glGetFloatv(pname : GL::Enum, value : GL::Float*) : Void
  fun get_doublev = glGetDoublev(pname : GL::Enum, value : GL::Double*) : Void

  fun get_integeri_v = glGetIntegeri_v(pname : GL::Enum, index : GL::Uint,
                                       value : GL::Int*) : Void
  fun get_integer64i_v = glGetInteger64i_v(pname : GL::Enum, index : GL::Uint,
                                           value : GL::Int64*) : Void
  fun get_booleani_v = glGetBooleani_v(pname : GL::Enum, index : GL::Uint,
                                       value : GL::Boolean*) : Void
  fun get_floati_v = glGetFloati_v(pname : GL::Enum, index : GL::Uint,
                                   value : GL::Float*) : Void
  fun get_doublei_v = glGetDoublei_v(pname : GL::Enum, index : GL::Uint,
                                     value : GL::Double*) : Void

  # State functions
  fun clear_color = glClearColor(red : GL::Float, green : GL::Float, blue : GL::Float,
                                 alpha : GL::Float) : Void
  fun clear = glClear(mask : GL::Bitfield) : Void
  fun enable = glEnable(cap : GL::Enum) : Void
  fun disable = glDisable(cap : GL::Enum) : Void
  fun depth_func = glDepthFunc(func : GL::Enum) : Void

  # Vertex and array buffers
  fun gen_vertex_arrays = glGenVertexArrays(n : GL::Sizei, ids : GL::Uint*) : Void
  fun bind_vertex_array = glBindVertexArray(id : GL::Uint) : Void

  fun gen_buffers = glGenBuffers(n : GL::Sizei, ids : GL::Uint*) : Void
  fun bind_buffer = glBindBuffer(target : GL::Enum, id : GL::Uint) : Void
  fun buffer_data = glBufferData(target : GL::Enum, size : GL::Sizeiptr, data : Void*,
                                 usage : GL::Enum) : Void

  fun enable_vertex_attrib_array = glEnableVertexAttribArray(index : GL::Uint) : Void
  fun disable_vertex_attrib_array = glDisableVertexAttribArray(index : GL::Uint) : Void
  fun vertex_attrib_pointer = glVertexAttribPointer(index : GL::Uint, size : GL::Int,
                                                    type : GL::Enum, normalized : GL::Boolean,
                                                    stride : GL::Sizei, pointer : Void*) : Void
  fun draw_arrays = glDrawArrays(mode : GL::Enum, first : GL::Int, count : GL::Sizei) : Void

  # Textures
  fun gen_textures = glGenTextures(n : GL::Sizei, textures : GL::Uint*) : Void
  fun bind_texture = glBindTexture(target : GL::Enum, texure : GL::Uint) : Void
  fun tex_image_2d = glTexImage2D(target : GL::Enum, level : GL::Int,
                                  internal_format : GL::Uint, width : GL::Sizei,
                                  height : GL::Sizei, border : GL::Int, format : GL::Enum,
                                  type : GL::Enum, pixels : Void*) : Void
  fun tex_parameteri = glTexParameteri(target : GL::Enum, pname : GL::Enum, param : GL::Int) : Void
  fun generate_mipmap = glGenerateMipmap(target : GL::Enum) : Void

  # Shaders and programs
  fun create_shader = glCreateShader(type : GL::Enum) : GL::Uint
  fun shader_source = glShaderSource(shader : GL::Uint, count : GL::Sizei, string : GL::Char**,
                                     length : GL::Int*) : Void
  fun compile_shader = glCompileShader(shader : GL::Uint) : Void
  fun delete_shader = glDeleteShader(shader : GL::Uint) : Void
  fun is_shader? = glIsShader(shader : GL::Uint) : GL::Boolean

  fun get_shader_iv = glGetShaderiv(shader : GL::Uint, pname : GL::Enum, params : GL::Int*) : Void
  fun get_shader_info_log = glGetShaderInfoLog(shader : GL::Uint, buf_size : GL::Sizei,
                                               length : GL::Sizei*, info_log : GL::Char*) : Void

  fun create_program = glCreateProgram() : GL::Uint
  fun attach_shader = glAttachShader(program : GL::Uint, shader : GL::Uint) : Void
  fun link_program = glLinkProgram(program : GL::Uint) : Void

  fun get_program_iv = glGetProgramiv(program : GL::Uint, pname : GL::Enum, params : GL::Int*) : Void
  fun get_program_info_log = glGetProgramInfoLog(program : GL::Uint, buf_size : GL::Sizei,
                                                 length : GL::Sizei*, info_log : GL::Char*) : Void

  fun use_program = glUseProgram(program : GL::Uint) : Void

  fun get_uniform_location = glGetUniformLocation(program : GL::Uint, name : GL::Char*) : GL::Int
  fun uniform_matrix_4fv = glUniformMatrix4fv(location : GL::Int, count : GL::Sizei,
                                              transpose : GL::Boolean, value : GL::Float*) : Void
end
