require "./gl"

module GL
  class Shader
    TYPEMAP = {
      vertex: GL::VERTEX_SHADER,
      fragment: GL::FRAGMENT_SHADER
    }

    def self.from_file(type, path)
      if !File.exists?(path)
        raise ArgumentError.new("#{path} is not readable")
      end

      source = File.read(path)
      from_source type, source
    end

    def self.from_source(type, source)
      if !TYPEMAP.has_key? type
        raise ArgumentError.new("#{type} is an unkown shader type")
      end

      type = TYPEMAP[type]
      shader = new type
      shader.with_source source
      shader
    end

    def initialize(type)
      @type = type
      @shader_id = GL::C.create_shader(@type)
    end

    def id
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
