module GL
  TRUE  = 1_u8
  FALSE = 0_u8

  # DataType
  BYTE            = 0x1400_u32
  UNSIGNED_BYTE   = 0x1401_u32
  SHORT           = 0x1402_u32
  UNSIGNED_SHORT  = 0x1403_u32
  INT             = 0x1404_u32
  UNSIGNED_INT    = 0x1405_u32
  FLOAT           = 0x1406_u32
  DOUBLE          = 0x140A_u32

  # AttribMask
  DEPTH_BUFFER_BIT   = 0x00000100_u32
  STENCIL_BUFFER_BIT = 0x00000400_u32
  COLOR_BUFFER_BIT   = 0x00004000_u32

  # Alpha/Depth/Stencil Function
  NEVER    = 0x0200_u32
  LESS     = 0x0201_u32
  EQUAL    = 0x0202_u32
  LEQUAL   = 0x0203_u32
  GREATER  = 0x0204_u32
  NOTEQUAL = 0x0205_u32
  GEQUAL   = 0x0206_u32
  ALWAYS   = 0x0207_u32

  # BeginMode
  TRIANGLES = 0x0004_u32

  # ErrorCode
  NO_ERROR          = 0_u32
  INVALID_ENUM      = 0x0500_u32
  INVALID_VALUE     = 0x0501_u32
  INVALID_OPERATION = 0x0502_u32
  STACK_OVERFLOW    = 0x0503_u32
  STACK_UNDERFLOW   = 0x0504_u32
  OUT_OF_MEMORY     = 0x0505_u32

  # glGetGraphicsResetStatus
  GUILTY_CONTEXT_RESET    = 0x8253_u32
  INNOCENT_CONTEXT_RESET  = 0x8254_u32
  UNKNOWN_CONTEXT_RESET   = 0x8255_u32

  # GetPName
  DEPTH_TEST = 0x0B71_u32
  TEXTURE_2D = 0x0DE1_u32

  # PixelFormat
  STENCIL_INDEX   = 0x1901_u32
  DEPTH_COMPONENT = 0x1902_u32
  RED             = 0x1903_u32
  GREEN           = 0x1904_u32
  BLUE            = 0x1905_u32
  ALPHA           = 0x1906_u32
  RGB             = 0x1907_u32
  RGBA            = 0x1908_u32

  # StringName
  VENDOR                    = 0x1F00_u32
  RENDERER                  = 0x1F01_u32
  VERSION                   = 0x1F02_u32
  EXTENSIONS                = 0x1F03_u32
  SHADING_LANGUAGE_VERSION  = 0x8B8C_u32

  # TextureMagFilter
  NEAREST = 0x2600_i32
  LINEAR  = 0x2601_i32

  # TextureMinFilter
  NEAREST_MIPMAP_NEAREST = 0x2700_i32
  LINEAR_MIPMAP_NEAREST  = 0x2701_i32
  NEAREST_MIPMAP_LINEAR  = 0x2702_i32
  LINEAR_MIPMAP_LINEAR   = 0x2703_i32

  # TextureParameterName
  TEXTURE_MAG_FILTER = 0x2800_u32
  TEXTURE_MIN_FILTER = 0x2801_u32
  TEXTURE_WRAP_S     = 0x2802_u32
  TEXTURE_WRAP_T     = 0x2803_u32

  # TextureWrapMode
  REPEAT = 0x2901_u32

  # OpenGL 1.5
  ARRAY_BUFFER = 0x8892_u32
  STATIC_DRAW  = 0x88E4_u32

  # OpenGL 2.0
  VERTEX_SHADER   = 0x8B31_u32
  FRAGMENT_SHADER = 0x8B30_u32
  COMPILE_STATUS  = 0x8B81_u32
  LINK_STATUS     = 0x8B82_u32
  INFO_LOG_LENGTH = 0x8B84_u32

  # OpenGL 3.0
  NUM_EXTENSIONS = 0x821D_u32
end
