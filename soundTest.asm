;****************************************************************
; iNES headers                                                  ;
;****************************************************************

  .inesprg 2  ; 2x 16KB PRG code (banks 0-3)
  .ineschr 1  ; 1x  8KB CHR data (bank 4)
  .inesmap 0  ; mapper 0 = NROM, no bank swapping
  .inesmir 0  ; horizontal mirroring (doesn't matter)
  
;****************************************************************
; Includes                                                     ;
;****************************************************************
    
  .include "ggsound\ggsound.inc"

CONTROLLER_A            = %10000000
CONTROLLER_B            = %01000000
CONTROLLER_SEL          = %00100000
CONTROLLER_START        = %00010000
CONTROLLER_UP           = %00001000
CONTROLLER_DOWN         = %00000100
CONTROLLER_LEFT         = %00000010
CONTROLLER_RIGHT        = %00000001
  
  .rsset $0000
  .include "ggsound\ggsound_zp.inc"
  
b                   .rs 1 
c                   .rs 1 
controllerDown      .rs 1 
controllerPressed   .rs 1 
controllerPrevious  .rs 1 
controller2Down      .rs 1 
controller2Pressed   .rs 1 
controller2Previous  .rs 1 
sleeping            .rs 1 
currentSong         .rs 1
  
  .rsset $0400
  .include "ggsound\ggsound_ram.inc" 

;****************************************************************
; RESET handler                                                 ;
;****************************************************************

  .bank 2
  .org $C000 
RESET:
  SEI               ; disable IRQs
  CLD               ; disable decimal mode
  LDX #$40          
  STX $4017         ; disable APU frame IRQ
  LDX #$FF          
  TXS               ; Set up stack
  INX               ; now X = 0
  STX $2000         ; disable NMI
  STX $2001         ; disable rendering
  STX $4010         ; disable DMC IRQs
                    
vblankwait1:        ; First wait for vblank to make sure PPU is ready
  BIT $2002         
  BPL vblankwait1   
                    
clrmem:             
  LDA #$00          
  STA $0000, x      
  STA $0100, x      
  STA $0300, x      
  STA $0400, x      
  STA $0500, x      
  STA $0600, x      
  STA $0700, x      
  INX
  BNE clrmem        
     
vblankwait2:        ; Second wait for vblank, PPU is ready after this
  BIT $2002              
  BPL vblankwait2
  
;****************************************************************
; Initialization logic                                          ;
;****************************************************************
  
initSoundEngine:  
InitializeSound:
  LDA #SOUND_REGION_NTSC
  STA <sound_param_byte_0
  LDA #LOW(song_list)
  STA <sound_param_word_0
  LDA #HIGH(song_list)
  STA <sound_param_word_0 + $01
  LDA #LOW(sfx_list)
  STA <sound_param_word_1
  LDA #HIGH(sfx_list)
  STA <sound_param_word_1 + $01
  LDA #LOW(envelopes_list)
  STA <sound_param_word_2
  LDA #HIGH(envelopes_list)
  STA <sound_param_word_2 + $01
  JSR sound_initialize

initPPU:
  LDA #%00000110           ; init PPU - disable sprites and background
  STA $2001                
  LDA #%10010000           ; enable NMI
  STA $2000                
  
;****************************************************************
; Game loop                                                     ;
;****************************************************************

GameLoop:  

  JSR ReadController
 
  playSounds1:

    LDA #$01
    STA b
    
    LDA #$00
    STA c
  
    .playSoundsLoop:
      LDA controllerPressed
      BEQ playSounds1Done
      AND b
      BEQ .checkNext
      
      LDX c
      LDA sfxMappings, x
      CMP #SFX_NONE
      BEQ .checkNext
      STA sound_param_byte_0
      LDA #soundeffect_one
      STA sound_param_byte_1
      JSR play_sfx
      JMP playSounds1Done
      
      .checkNext:
        INC c
        ASL b
        LDA b      
        BEQ playSounds1Done
        CMP #CONTROLLER_SEL
        BNE .playSoundsLoop
        INC c        
        ASL b                 ; skip select
        JMP .playSoundsLoop
  
  playSounds1Done:
  
  playSounds2:

    LDA #$01
    STA b
    
    LDA #$00
    STA c
  
    .playSoundsLoop:
      LDA controller2Pressed
      BEQ playSounds2Done
      AND b
      BEQ .checkNext
      
      LDX c
      LDA sfxMappings2, x
      CMP #SFX_NONE
      BEQ .checkNext
      STA sound_param_byte_0
      LDA #soundeffect_one
      STA sound_param_byte_1
      JSR play_sfx
      JMP playSounds2Done
      
      .checkNext:
        INC c
        ASL b
        LDA b      
        BEQ playSounds2Done
        JMP .playSoundsLoop
  
  playSounds2Done:
  
  .changeMusic:
  
    LDA controllerPressed
    AND #CONTROLLER_SEL
    BEQ .changeMusicDone
    
    ;LDA currentSong
    ;CMP #song_index_song_none
    ;BEQ .wrapSong
    ;
    ;.incSong:
    ;  INC currentSong
    ;  JMP .changeSong
    ;
    ;.wrapSong:  
    ;  LDA #$00
    ;  STA currentSong
    ;
    ;.changeSong:
    ;  LDA currentSong
    ;  STA sound_param_byte_0
    ;  JSR play_song    
    
  .changeMusicDone:
  
GameLoopDone:               
  JSR WaitForFrame            ; always wait for a frame at the end of the loop iteration
  JMP GameLoop
  
;****************************************************************
; NMI handler                                                   ;
;****************************************************************

NMI:
  PHA                       ; back up registers
  TXA                       
  PHA                       
  TYA                       
  PHA                       
                                                         
  soundengine_update
     
  LDA #$00
  STA sleeping
     
  PLA                       ; restore regs and exit
  TAY                       
  PLA
  TAX
  PLA
  RTI

  RTI
  
;****************************************************************
; Global subroutines                                            ;
;****************************************************************

;****************************************************************
; Name:                                                         ;
;   WaitForFrame                                                ;
;                                                               ;
; Description:                                                  ;
;   Wait for NMI to happen, then exit                           ;
;****************************************************************

WaitForFrame
  INC sleeping
  .loop:
    LDA sleeping
    BNE .loop
  RTS

;****************************************************************
; Name:                                                         ;
;   ReadController                                              ;
;                                                               ;
; Description:                                                  ;
;   Reads the state of the first controller                     ;
;                                                               ;
; Variables used:                                               ;
;  b                                                            ;
;****************************************************************

ReadController:
 
  .readController:
  
    LDA #$01
    STA $4016
    LDA #$00
    STA $4016                 ; latch buttons
    LDX #$08                  ; read 8 buttons for player 1
                              
    .loop:                    
      LDA $4016               
      LSR A                   
      ROL b                   ; store the buttons in b for now
      DEX
      BNE .loop
     
    LDA #$FF
    EOR controllerDown        ; NOT previous state of controllers
    AND b                     ; AND with the current state
    STA controllerPressed     ; store that as controllerPressed
    LDA controllerDown        ; load previous state of controllers
    STA controllerPrevious    ; store that in controllerPrevious
    LDA b                     ; load the placeholder
    STA controllerDown        ; finally, store that as current state of controllers
    
  .readControllerDone:  
  
  .readController2:
  
    LDA #$01
    STA $4017
    LDA #$00
    STA $4017                 ; latch buttons
    LDX #$08                  ; read 8 buttons for player 1
                              
    .loop2:                    
      LDA $4017               
      LSR A                   
      ROL b                   ; store the buttons in b for now
      DEX
      BNE .loop2
     
    LDA #$FF
    EOR controller2Down        ; NOT previous state of controllers
    AND b                     ; AND with the current state
    STA controller2Pressed     ; store that as controllerPressed
    LDA controller2Down        ; load previous state of controllers
    STA controller2Previous    ; store that in controllerPrevious
    LDA b                     ; load the placeholder
    STA controller2Down        ; finally, store that as current state of controllers
    
  .readControllerDone2:  
  
  RTS
  
;****************************************************************
; Modules import                                                ;
;****************************************************************
  
  .bank 3
  .org $E000

  .include "lib\soundMapping.asm"
  .include "ggsound\ggsound.asm"  
   
  .bank 0
  .org $8000
  
  SoundStart:
  .include "ggsound\sound.asm"   
  SoundEnd:
  
  .bank 1
  .org $A000

;****************************************************************
; Vectors                                                       ;
;****************************************************************

  .bank 3
  .org $FFFA  ; vectors starts here
  .dw NMI     ; when an NMI happens (once per frame if enabled) the processor will jump to the label NMI:
  .dw RESET   ; when the processor first turns on or is reset, it will jump to the label RESET:
  .dw 0       ; external interrupt IRQ is not used