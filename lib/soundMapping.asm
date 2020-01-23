SFX_NONE     = $FF
SFX_NONE_SEL = SFX_NONE

sfxMappings:
  .byte sfx_index_sfx_option_selected     ; CONTROLLER_RIGHT        = %00000001
  .byte sfx_index_sfx_option_changed      ; CONTROLLER_LEFT         = %00000010
  .byte sfx_index_sfx_pause               ; CONTROLLER_DOWN         = %00000100
  .byte sfx_index_sfx_keycard             ; CONTROLLER_UP           = %00001000
  .byte sfx_index_sfx_blinker             ; CONTROLLER_START        = %00010000
  .byte SFX_NONE_SEL                      ; CONTROLLER_SEL          = %00100000 <- this changes songs so must always be SFX_NONE_SEL
  .byte SFX_NONE                          ; CONTROLLER_B            = %01000000
  .byte SFX_NONE                          ; CONTROLLER_A            = %10000000
  