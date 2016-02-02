SFX_NONE = $FF

sfxMappings:
  .byte sfx_index_sfx_invalid  ; CONTROLLER_RIGHT        = %00000001
  .byte sfx_index_sfx_action   ; CONTROLLER_LEFT         = %00000010
  .byte sfx_index_sfx_mirror   ; CONTROLLER_DOWN         = %00000100
  .byte sfx_index_sfx_target   ; CONTROLLER_UP           = %00001000
  .byte sfx_index_sfx_success  ; CONTROLLER_START        = %00010000
  .byte SFX_NONE               ; CONTROLLER_SEL          = %00100000
  .byte SFX_NONE               ; CONTROLLER_B            = %01000000
  .byte SFX_NONE               ; CONTROLLER_A            = %10000000
  