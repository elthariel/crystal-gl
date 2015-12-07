require "../utils/macros"
require "../lib/libsoil"
require "./const"

module SOIL
  module C
    import_fun(LibSOIL, load_texture, free_image_data, last_result)
    import_fun_out(LibSOIL, load_image, true, true,
                   {path: false, width: true, height: true, channels: true, mode: false})
  end

  def self.last_result
    String.new(C.last_result)
  end
end
