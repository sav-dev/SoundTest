SFX_NONE     = $FF
SFX_NONE_SEL = SFX_NONE

sfxMappings:
  .byte SFX_NONE_SEL  ; CONTROLLER_RIGHT        = %00000001
  .byte SFX_NONE_SEL  ; CONTROLLER_LEFT         = %00000010
  .byte SFX_NONE_SEL  ; CONTROLLER_DOWN         = %00000100
  .byte SFX_NONE_SEL  ; CONTROLLER_UP           = %00001000
  .byte SFX_NONE_SEL  ; CONTROLLER_START        = %00010000
  .byte SFX_NONE_SEL  ; CONTROLLER_SEL          = %00100000 <- this changes songs so must always be SFX_NONE_SEL
  .byte SFX_NONE_SEL  ; CONTROLLER_B            = %01000000
  .byte SFX_NONE_SEL  ; CONTROLLER_A            = %10000000
  