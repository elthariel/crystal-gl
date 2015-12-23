require "./gen_const"

module GL
  TRUE  = 1_u8
  FALSE = 0_u8

  # ErrorCode
  NO_ERROR          = 0_u32
  # INVALID_ENUM      = 0x0500_u32
  # INVALID_VALUE     = 0x0501_u32
  # INVALID_OPERATION = 0x0502_u32
  # STACK_OVERFLOW    = 0x0503_u32
  # STACK_UNDERFLOW   = 0x0504_u32
  # OUT_OF_MEMORY     = 0x0505_u32
end
