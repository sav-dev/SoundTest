song_index_laser = 0
song_index_song_none = 1
song_index_editor_song = 2

sfx_index_sfx_invalid = 0
sfx_index_sfx_action = 1
sfx_index_sfx_mirror = 2
sfx_index_sfx_target = 3
sfx_index_sfx_success = 4

song_list:
  .dw laser
  .dw song_none
  .dw editor_song

sfx_list:
  .dw sfx_invalid
  .dw sfx_action
  .dw sfx_mirror
  .dw sfx_target
  .dw sfx_success

volume:
  .dw volume0
  .dw volume1
  .dw volume2
  .dw volume3
  .dw volume4
  .dw volume5
  .dw volume6
  .dw volume7

pitch:
  .dw pitch0

duty:
  .dw duty0
  .dw duty1
  .dw duty2
  .dw duty3

volume0:
  .db 12,11,6,2,0,ENV_STOP
volume1:
  .db 3,6,9,11,12,12,12,0,ENV_STOP
volume2:
  .db 3,ENV_STOP
volume3:
  .db 12,12,12,12,0,ENV_STOP
volume4:
  .db 11,11,11,11,11,11,11,0,ENV_STOP
volume5:
  .db 12,8,3,8,12,ENV_LOOP,0
volume6:
  .db 0,ENV_STOP
volume7:
  .db 0,ENV_STOP

pitch0:
  .db 0,ENV_STOP

duty0:
  .db 0,128,192,128,128,128,DUTY_ENV_STOP
duty1:
  .db 192,64,64,DUTY_ENV_STOP
duty2:
  .db 128,64,DUTY_ENV_STOP
duty3:
  .db 0,DUTY_ENV_STOP

laser:
  .db 0
  .db 6
  .db 0
  .db 5
  .dw laser_square1
  .dw laser_square2
  .dw laser_triangle
  .dw laser_noise
  .dw volume
  .dw pitch
  .dw duty

laser_square1:
  .db CAL,low(laser_square1_0),high(laser_square1_0)
  .db GOT
  .dw laser_square1

laser_square2:
  .db CAL,low(laser_square2_0),high(laser_square2_0)
  .db GOT
  .dw laser_square2

laser_triangle:
  .db CAL,low(laser_triangle_0),high(laser_triangle_0)
  .db GOT
  .dw laser_triangle

laser_noise:
  .db CAL,low(laser_noise_0),high(laser_noise_0)
  .db GOT
  .dw laser_noise

laser_square1_0:
  .db STV,7,STP,0,SDU,3,SLL,64,A0
  .db RET

laser_square2_0:
  .db STV,7,STP,0,SDU,3,SLL,64,A0
  .db RET

laser_triangle_0:
  .db STV,7,STP,0,SDU,3,SLL,64,A0
  .db RET

laser_noise_0:
  .db STV,2,SDU,2,STP,0,SLL,64,4
  .db RET

song_none:
  .db 0
  .db 6
  .db 0
  .db 5
  .dw 0
  .dw 0
  .dw 0
  .dw 0
  .dw volume
  .dw pitch
  .dw duty

editor_song:
  .db 0
  .db 6
  .db 0
  .db 5
  .dw 0
  .dw 0
  .dw 0
  .dw 0
  .dw volume
  .dw pitch
  .dw duty

sfx_invalid:
  .db 0, 1
  .db 0, 1
  .dw 0
  .dw 0
  .dw 0
  .dw sfx_invalid_noise
  .dw volume
  .dw pitch
  .dw duty

sfx_invalid_noise:
  .db CAL,low(sfx_invalid_noise_0),high(sfx_invalid_noise_0)
  .db TRM
sfx_invalid_noise_0:
  .db SLL,8,STV,1,SDU,1,STP,0,9
  .db RET

sfx_action:
  .db 0, 1
  .db 0, 1
  .dw 0
  .dw 0
  .dw 0
  .dw sfx_action_noise
  .dw volume
  .dw pitch
  .dw duty

sfx_action_noise:
  .db CAL,low(sfx_action_noise_0),high(sfx_action_noise_0)
  .db TRM
sfx_action_noise_0:
  .db SLL,6,STV,0,SDU,0,STP,0,6
  .db RET

sfx_mirror:
  .db 0, 1
  .db 0, 1
  .dw sfx_mirror_square1
  .dw 0
  .dw 0
  .dw 0
  .dw volume
  .dw pitch
  .dw duty

sfx_mirror_square1:
  .db CAL,low(sfx_mirror_square1_0),high(sfx_mirror_square1_0)
  .db TRM
sfx_mirror_square1_0:
  .db SLL,5,STV,3,STP,0,SDU,3,AS6
  .db RET

sfx_target:
  .db 0, 1
  .db 0, 1
  .dw sfx_target_square1
  .dw 0
  .dw 0
  .dw 0
  .dw volume
  .dw pitch
  .dw duty

sfx_target_square1:
  .db CAL,low(sfx_target_square1_0),high(sfx_target_square1_0)
  .db TRM
sfx_target_square1_0:
  .db STV,5,STP,0,SDU,3,SLL,6,F3,SLL,1,STV,6,C3
  .db RET

sfx_success:
  .db 0, 1
  .db 0, 1
  .dw sfx_success_square1
  .dw 0
  .dw 0
  .dw 0
  .dw volume
  .dw pitch
  .dw duty

sfx_success_square1:
  .db CAL,low(sfx_success_square1_0),high(sfx_success_square1_0)
  .db TRM
sfx_success_square1_0:
  .db STV,4,STP,0,SDU,3,SLL,12,F3,G3,A3,SLL,6,B3,B3,B3,SLL,0
  .db B3
  .db RET

