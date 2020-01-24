SFX_NONE     = $FF
SFX_NONE_SEL = SFX_NONE

sfxMappings:
  .byte sfx_index_sfx_shot_gunrob     ; CONTROLLER_RIGHT        = %00000001
  .byte sfx_index_sfx_shot_player      ; CONTROLLER_LEFT         = %00000010
  .byte sfx_index_sfx_shot_turret               ; CONTROLLER_DOWN         = %00000100
  .byte sfx_index_sfx_shot_tank             ; CONTROLLER_UP           = %00001000
  .byte sfx_index_sfx_shot_boss             ; CONTROLLER_START        = %00010000
  .byte SFX_NONE_SEL                      ; CONTROLLER_SEL          = %00100000 <- this changes songs so must always be SFX_NONE_SEL
  .byte sfx_index_sfx_expl_player         ; CONTROLLER_B            = %01000000
  .byte sfx_index_sfx_expl_blast                          ; CONTROLLER_A            = %10000000
  