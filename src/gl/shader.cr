require "./gl"

module GL
  class Shader
    def self.vertex(source = nil)
      shader = new GL::VERTEX_SHADER
      shader.with_source(source) if source
      shader
    end

    def self.fragment(source = nil)
      shader = new GL::FRAGMENT_SHADER
      shader.with_source(source) if source
      shader
    end

    def initialize(type)
      @type = type
      @shader_id = GL::C.create_shader(@type)
    end

    def shader_id
      @shader_id
    end

    def with_source(source : String)
      p = source.cstr
      GL::C.shader_source @shader_id, 1, pointerof(p), nil
      self
    end

    def compile
      GL::C.compile_shader @shader_id

      result = GL::C.get_shader_iv @shader_id, GL::COMPILE_STATUS
      info_log_length = GL::C.get_shader_iv @shader_id, GL::INFO_LOG_LENGTH
      info_log = String.new(info_log_length) do |buffer|
        GL::C.get_shader_info_log @shader_id, info_log_length, nil, buffer
        {info_log_length, info_log_length}
      end
      raise "Error compiling shader: #{info_log}" unless result

      self
    end

    def delete
      GL::C.delete_shader @shader_id
    end
  end
end
