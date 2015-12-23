require "./gl"

module GL
  module Caps
    macro define_cap(name)
      def self.{{name.id}}?
        value = GL::C.is_enabled?(GL::{{name.id.upcase}})
        # err = GL.last_error
        # value
      end

      def self.enable_{{name.id}}!
        GL::C.enable(GL::{{name.id.upcase}})
        GL.last_error
      end

      def self.disable_{{name.id}}!
        GL::C.disable(GL::{{name.id.upcase}})
        GL.last_error
      end
    end

    define_cap(:blend)
    define_cap(:cull_face)
    define_cap(:depth_test)
    define_cap(:dither)
    define_cap(:polygon_offset_fill)
    define_cap(:sample_alpha_to_coverage)
    define_cap(:sample_coverage)
    define_cap(:scissor_test)
    define_cap(:stencil_test)
  end
end
