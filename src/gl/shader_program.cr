require "../lib/gl"

module GL
  class ShaderProgram
    def initialize
      @program_id = LibGL.create_program
    end

    def program_id
      @program_id
    end

    def attach(shader)
      LibGL.attach_shader @program_id, shader.shader_id
      self
    end

    def link
      LibGL.link_program @program_id

      LibGL.get_program_iv @program_id, LibGL::LINK_STATUS, out result
      LibGL.get_program_iv @program_id, LibGL::INFO_LOG_LENGTH, out info_log_length
      info_log = String.new(info_log_length) do |buffer|
        LibGL.get_program_info_log @program_id, info_log_length, nil, buffer
        {info_log_length, info_log_length}
      end
      raise "Error linking shader program: #{info_log}" unless result

      self
    end

    def use
      LibGL.use_program @program_id
      self
    end

    def set_uniform_matrix_4f(name, transpose, data)
      location = LibGL.get_uniform_location @program_id, name.cstr
      LibGL.uniform_matrix_4fv location, 1, GL.to_boolean(transpose), data
    end
  end
end
