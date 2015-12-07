require "./libgl"

@[Link("SOIL")]
@[Link(framework: "CoreFoundation")] ifdef darwin
lib LibSOIL
  fun load_texture = SOIL_load_OGL_texture(filename : UInt8*, force_channels : Int32, reuse_texture_ID : UInt32, flags : UInt32) : UInt32
  fun load_image = SOIL_load_image(filename : UInt8*, width : Int32*, height : Int32*, channels : Int32*, force_channels : Int32) : UInt8*
  fun free_image_data = SOIL_free_image_data(data : UInt8*) : Void
  fun last_result = SOIL_last_result() : UInt8*
end

