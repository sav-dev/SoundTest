SFX_NONE     = $FF
SFX_NONE_SEL = SFX_NONE

sfxMappings:
  ; RIGHT
  .byte sfx_index_sfx_shot_gunrob  
  ; LEFT
  .byte sfx_index_sfx_shot_player  
  ; DOWN
  .byte sfx_index_sfx_shot_turret  
  ; UP
  .byte sfx_index_sfx_shot_tank    
  ; START
  .byte sfx_index_sfx_shot_boss    
  ; SEL
  .byte SFX_NONE_SEL               
  ; B
  .byte SFX_NONE  
  ; A
  .byte SFX_NONE   
  
sfxMappings2:
  ; RIGHT
  .byte sfx_index_sfx_expl_player  
  ; LEFT
  .byte sfx_index_sfx_expl_blast  
  ; DOWN
  .byte sfx_index_sfx_expl_org
  ; UP
  .byte sfx_index_sfx_option_selected
  ; START
  .byte sfx_index_sfx_option_changed   
  ; SEL
  .byte sfx_index_sfx_pause    
  ; B
  .byte sfx_index_sfx_blinker  
  ; A
  .byte sfx_index_sfx_keycard               