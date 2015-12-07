require "../utils/macros"
require "../lib/libsoil"
require "./const"

module SOIL
  module C
    import_fun(LibSOIL, load_texture, free_image_data, last_result)

    @[AlwaysInline]
    def self.load_image(path, mode)
      data = LibSOIL.load_image(path, out width, out height, out channels, mode)
      if data.null?
        {data, 0, 0, 0}
      else
        {data, width, height, channels}
      end
    end
  end

  def self.last_result
    String.new(C.last_result)
  end
end
