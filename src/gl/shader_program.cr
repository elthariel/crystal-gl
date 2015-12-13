require "./gl"

module GL
  class ShaderProgram
    def self.simple(vertex_path, fragment_path)
      vertex_shader = GL::Shader.from_file(:vertex, vertex_path).compile
      fragment_shader = GL::Shader.from_file(:fragment, fragment_path).compile

      program = new
      program.attach vertex_shader
      program.attach fragment_shader
      program.link

      vertex_shader.delete
      fragment_shader.delete

      program
    end

    def initialize
      @program_id = GL::C.create_program
    end

    def program_id
      @program_id
    end

    def attach(shader)
      GL::C.attach_shader @program_id, shader.shader_id
      self
    end

    def link
      GL::C.link_program @program_id

      result = GL::C.get_program_iv @program_id, GL::LINK_STATUS
      info_log_length = GL::C.get_program_iv @program_id, GL::INFO_LOG_LENGTH
      info_log = String.new(info_log_length) do |buffer|
        GL::C.get_program_info_log @program_id, info_log_length, nil, buffer
        {info_log_length, info_log_length}
      end
      raise "Error linking shader program: #{info_log}" unless result

      self
    end

    def use
      GL::C.use_program @program_id
      self
    end

    def set_uniform_matrix_4f(name, transpose, data)
      location = GL::C.get_uniform_location @program_id, name.cstr
      GL::C.uniform_matrix_4fv location, 1, GL.to_boolean(transpose), data
    end
  end
end
