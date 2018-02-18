TITLE     .LOCAL

DLI:    pha

        lda DLI_HLP
        beq DLI1
        cmp #1
        beq DLI2
        
        lda #$06
        sta COLPF1
        lda #$00
        sta COLPF2
        
        pla
        rti
        
DLI2:   lda #$04
        sta COLPF1
        lda #$00
        sta COLPF2

        
        inc DLI_HLP
        pla
        rti
        
DLI1:   lda #$0e
        sta COLPF1
        lda #$00
        sta COLPF2

        
        inc DLI_HLP
        pla
        rti

;------------ TITLE.ASM
TSETUP: lda #0
        sta SDMCTL
        sta PNTR
        sta RTCLOKL
        sta CDTMR1
        sta CDTMR1+1
        sta CDTMR2
        sta CDTMR2+1
        
        ldx #$60
tsclr:
        sta $220,x
        dex
        bpl tsclr
        
        jsr HALT
        
        lda SETUP_HLP
        bne set1
        
        ldx #3
copmask:
        lda MASK,x
        sta RAM_MASK,x
        dex
        bpl copmask
        
        lda #0
        sta CNUM
        sta DCV
        sta DEMO
        sta STCN

        inc SETUP_HLP        
set1:   
        
        lda RAM_MASK+3
        sta RAM_MASK+1
        lda RAM_MASK+2
        sta RAM_MASK
        
        ldx #5
copc:   lda COLS,x
        sta PCOLR3,x
        dex
        bpl copc
        
        lda <INST_RAM
        sta CHAD
        lda >INST_RAM
        sta CHAD+1
        
        lda >IFNT_RAM
        sta SCHBASE
        
        lda #$ff
        sta CDTMR1+1
        sta TBUF

        lda #$00        ;disable NMI & IRQ
        sta NMIEN
        
        lda <TITLE.DLI
        sta VDLI
        lda >TITLE.DLI
        sta VDLI+1
        
        lda #$c0        ;enable interrupts
        sta NMIEN
                
        lda #2
        sta CHACTL

        sta SKCTL
        
        lda #4
        sta CONSOL
        rts      
        
RESET   equ *        
TITLE:  
        ldx #$ff
        txs
        
        lda CNUM
        ldx DEMO
        beq nod
        lda #0
        sta DEMO
        lda DCV    
nod:
        sta STCN
        sta CNUM
        
        jsr TSETUP
        jsr HALT
        
        lda <TPDL
        sta SDLSTL
        lda >TPDL
        sta SDLSTH

        lda #33
        sta SDMCTL

        jsr CLS
        
;---------------------------------------
TPLP:
        jsr BIGR
        
;        jsr HALT
;        ldx #36
;        lda #$0e
;        jsr WLIN
;        lda #$00
;        sta COLPF2
        
;        ldx #60
;        lda #$04
;        jsr WLIN
        
;        ldx #74
;        lda #$06
;        jsr WLIN
        
;* print char -------

        lda #0
        sta VOIC+1
                
        ldy PNTR
        lda CDTMR1+1
        asl
        asl
        asl
        asl
        and #$80
        sta SCRN+352,y
        
        lda CDTMR1
        ora CDTMR1+1
        bne nopr
        
        ldy PNTR
        cpy #32
        dey
        bcs nxt1
        iny
        lda (CHAD),y
        
        pha
        and #3
        adc #2
        sta CDTMR1+1
        
        lda #$10
        sta VOIC
        lda #$82
        sta VOIC+1
        pla
        
        cmp #$ff
        bne conp
        
;* end of text ----------

        lda #$4
        sta CDTMR1
        
        lda <(INST_RAM-1)
        sta CHAD
        lda >(INST_RAM-1)
        sta CHAD+1
        jmp nopr
        
conp:   cmp #$40
        bne PUTC
        
;* nxtln ----------------

nxtl:   lda #0
        sta SCRN+352,y
        
nxt1:   tya
        adc CHAD
        sta CHAD
        bcc *+4
        inc CHAD+1
        
        lda #15
        sta CDTMR1+1
        
        lda #$02
        sta VOIC
        lda #$c4
        sta VOIC+1
                
        ldy #0
        lda SCRN+160,y
        sta SCRN+128,y
        iny
        bne *-7
        
        sty PNTR
        beq nopr
        
PUTC:   sta SCRN+352,y
        inc PNTR
        
nopr:
        lda #$00
        sta ATRACT
        
noha:   lda CDTMR1
        cmp #1
        beq dem
        
        jmp qq
dem:    
;        jmp CONGR
        lda #1
        sta DEMO
        lda CNUM
        sta DCV
        jmp PLAJ

qq:     
        jsr HALT
        ldx #59
        lda #$0e
        jsr WLIN

        jsr TETR

        beq PLAJ
        jmp TPLP
;* PLAY! ----------------

PLAJ    lda #$00 ;STCN
        and #%11111100
        sta CNUM
;        inc TITLE_HLP
;* chck has        
        
liv3:
        lda #0
        sta CNUM
        lda #$08 
        sta LIVS
        
        lda #0
        sta CDTMR1
        sta CDTMR1+1
               
        jmp GAME.PLAY
;* Congratulations ------

CONGR:

        lda >SFNT
        sta SCHBASE
        
        lda <CDL1
        sta SDLSTL
        lda >CDL1
        sta SDLSTH
        
        ldx #5
chgclrs1:
        lda COLS+6,x
        sta PCOLR3,x
        dex
        bpl chgclrs1

        jsr HALT

        
;************************

        lda #$ff
        sta Y_POS
        sta FX
        
        jsr DISP
        
        ldx #60
        jsr WAIT
        
;* wchodzi Robbo

        lda #30
        sta FX
        lda #12
        sta FY
        lda #$05
        sta RUCH
        
        lda #$05
        jsr SOUND.SOUND_
        
wcho:   lda RUCH
        eor #$10
        sta RUCH
        jsr DIWA
        dec FX
        lda FX
        cmp #22
        bcs wcho
        
        lda #$06
        sta RUCH
        jsr DIWA
        
        ldx #12
        jsr WAIT
        
;* laduj statek

        lda #12
        sta X_POS
        lda #0
        sta Y_POS
        
        lda #$0e
        jsr SOUND.SOUND_
        
land:   jsr DIWA
        lda RUCH
        EOR #$10
        sta RUCH
        inc Y_POS
        lda Y_POS
        cmp #12
        bcc land
        
;* macha raczka
        lda #$0d
        jsr SOUND.SOUND_
        
        ldy #14
mach:   tya
        pha
        lda #$13
        sta RUCH
        jsr DIWA
        lda #$12
        sta RUCH
        jsr DIWA
        pla
        tay
        dey
        bne mach
        
;* idzie

        lda #$05
        sta RUCH
        
idzi:   lda RUCH
        eor #$10
        sta RUCH
        jsr DIWA
        dec FX
        lda FX
        cmp #13
        bcs idzi
        
;* odlatuje

        lda #$0b
        jsr SOUND.SOUND_
        
odla:   jsr DIWA
        dec FY
        dec Y_POS
        lda Y_POS
        cmp #$fe
        bne odla
        
        lda #$05
        jsr SOUND.SOUND_
        
        ldx #60
        jsr WAIT
;        .byte "tutaj"
;* congratulaions!

        lda #0
        ldx #6
chgclrs2:
        sta PCOLR3,x
        dex
        bpl chgclrs2
        
        jsr HALT
        
        lda <CDL2
        sta SDLSTL
        lda >CDL2
        sta SDLSTH
        
        lda >IFNT_RAM
        sta SCHBASE
        
        ldx #0
        lda #$60
fillscr1:
        sta SCRN+$000,x
        sta SCRN+$100,x
        sta SCRN+$200,x
        dex
        bne fillscr1
        
        ldy #0
rozj:   sty COLOR1
        ldx #2
        jsr WAIT
        iny
        cpy #$0f
        bcc rozj
        
        lda #$02
        sta COLOR2
        
        lda #$00
        jsr SOUND.SOUND_
        
copt:   ldy RND
        lda COTX_RAM,y
        sta SCRN,y
        ldy RND
        lda COTX_RAM+$100,y
        sta SCRN+$100,y
        ldy RND
        lda COTX_RAM+$200,y
        sta SCRN+$200,y
        
        ldx #0
        lda $ffff
        dex
        bne *-4
        
        jsr TETR
        bne copt
        
;**********************

        lda #$09
        jsr SOUND.SOUND_
        
        ldx #116
znik:   cpx VCOUNT
        bne znik
        ldy #$0f
z1:     sty COLPF2
        sty WSYNC
        dey
        bpl z1
        
        lda #$00
        sta COLPF2
        sta COLPF1
        sta COLBK
        dex
        bpl znik
        
        lda #$0d
        jsr SOUND.SOUND_

;**********************

        lda #0
        sta CNUM
        sta DEMO
        jmp TITLE
                
;**********************

;* displayy scene

DIWA:   ldx #6
        jsr WAIT
        
DISP:   lda #92
        cmp VCOUNT
        bne *-3
        
        jsr CLS
        
;* ground ---------------

        ldx #30
        
grou:   txa
        pha
        ldy #14
        lda #16+$80
        jsr PUT_
        pla
        tax
        dex
        dex
        bpl grou
        
;* stars

        ldy #32
star:   tya
        pha
        lda STAT,y
        tax
        lda STAT+1,y
        tay
        lda #0
        jsr PUT_
        pla
        tay
        dey
        dey
        bpl star
        
;* disp robbo

        ldx FX
        ldy FY
        lda RUCH
        jsr PUT_
        
;* disp ship 

ship:   ldx X_POS
        ldy Y_POS
        lda HELP_20
        asl
        asl
        asl
        and #$80
        pha
        ora #2
        jsr PUT_
        ldx X_POS
        inx
        inx
        ldy Y_POS
        pla
        ora #3
        jmp PUT_
;* procedury ------------
CLS:    ldx #0
        txa
cls1:   sta SCRN+$000,x
        sta SCRN+$100,x
        sta SCRN+$200,x
        sta SCRN+$300,x
        dex
        bne cls1
        rts
;* ----------------------
PUT_:
        cpx #31
        bcc *+3
        rts
        
        cpy #15
        bcc *+3
        rts
        
        pha
        
        lda #0
        sta SCRA+1
        tya
        asl
        asl
        asl
        rol SCRA+1
        asl
        rol SCRA+1
        asl
        rol SCRA+1
        
        stx ADDR
        adc ADDR
        sta SCRA
        
        adc <SCRN
        sta SCRA
        lda >SCRN
        adc SCRA+1
        sta SCRA+1
        
        lda #0
        sta ADDR ;-invr
        
        pla
        asl
        ror ADDR
        
        cmp #32
        bcc *+4
        adc #31
        
        ora ADDR
        
        tax
        ldy #0
        sta (SCRA),y
        iny
        inx
        txa
        sta (SCRA),y
        
        clc
        adc #31
        tax
        ldy #32
        sta (SCRA),y
        iny
        inx
        txa
        sta (SCRA),y
        
        rts
        
;* Big robbo ------------

BIGR:
        ldx #3
ccol:   lda RND
        and #31
        bne nocc
        lda COLOR0,x
        clc
        adc #$10
        sta COLOR0,x
nocc:   dex
        bpl ccol
        
        ldx #4
        
big0:   txa
        pha
        
        sta HLP
        asl 
        adc HLP
        adc <(SCRN+1)
        sta SCRA
        lda >SCRN
        sta SCRA+1
        
        lda ROBO,x
        
        asl
        asl
        asl
        sta ADDR
        
        ldx #7
        
big1:   txa
        pha
        
        lda #0
        ldy #0
        
        ldx ADDR
        lda IFNT_RAM+$3e8,x
        sta HLP
        
big3:   ldx #3

big4:   asl HLP
        php
        rol
        plp
        rol
        dex
        bpl big4
        
        and RAM_MASK,y
        sta (SCRA),y
        
        lda #0
        iny
        cpy #1
        beq big3
        
        jsr ROLM
        
        clc
        lda SCRA
        adc #16
        sta SCRA 
        bcc *+4
        inc SCRA+1
        
        inc ADDR
        
        pla
        tax
        dex
        bpl big1
        
        pla
        tax
        dex
        bpl big0
        
;* rotate mask ----------

        lda RTCLOKL ;HELP20
        lsr
        and #1
        bne rts_
        
        lda RND
        and #31
        bne rotm      
        inc ROTM_HLP
        
rotm:   lda ROTM_HLP
        lsr
        bcc rorm
        
;* rotate left mask

rolm:   ldx #1

rol1:   asl RAM_MASK+1
        rol RAM_MASK
        php
        ror RAM_MASK+1
        plp
        rol RAM_MASK+1
        
        dex
        bpl rol1
        
rts_:   rts

;* rotate right mask

rorm:   ldx #1

ror1:   lsr RAM_MASK
        ror RAM_MASK+1
        php
        rol RAM_MASK
        plp
        ror RAM_MASK
        
        dex
        bpl ror1
        rts
        
ROBO    .byte $00, $01, $02, $02, $01

MASK    .byte $00, $00
        .byte %11111010, %01011010
        
;* wait one frame
WAIT:   jsr HALT
        dex
        bne WAIT
        
HALT    lda RTCLOKL
        cmp RTCLOKL
        beq *-2
        rts
;* tst trigger
TETR:   lda TRIG0
        rts
        
;* wait for line --------
WLIN:   cpx VCOUNT
        bne WLIN
        sta COLPF1
        rts
                
;------------------------
COLS     .byte $00, $b2, $b4, $b8, $00, $00
         .byte $00, $c2, $78, $0c, $b4, $00

;PAL----------------------------------------
;        .byte $00, $72, $74, $78, $00, $00
;        .byte $00, $32, $c8, $0c, $74, $00
        
;------------------------
TBUF    .byte "1989.09.18 "
HALE    equ *-TBUF
        .byte "JANUSZ PELC"
;        align 1024
TPDL    .byte $70, $70 ;, $70

        .byte $30, $4A, <SCRN, >SCRN, $00, $0A
        .byte $00, $0A, $00, $0A, $00, $0A, $00, $0A
        .byte $00, $0A, $00, $0A, $40, $A0, $42, <TEXT_RAM, >TEXT_RAM
        
;        .byte $41, <TPDL, >TPDL
        
        .byte $30, $02, $30, $02, $10, $02, $d0, $02, $02
        .byte $40, $A0, $4c, <LINE, >LINE, $00, $42
        .byte <(SCRN+128), >(SCRN+128), $02, $02, $02, $02, $02, $02
        .byte $02, $00, $4c, <LINE, >LINE, $41, <TPDL, >TPDL 

CDL1    .byte $70, $70, $70, $70, $70, $70, $44, <SCRN, >SCRN
        .byte $04, $04, $04, $04, $04, $04, $04, $04, $04
        .byte $04, $04, $04, $04, $04, $04, $41, <CDL1, >CDL1

CDL2    .byte $70, $70, $70, $70, $70, $42, <SCRN, >SCRN, $02
        .byte $02, $02, $02, $02, $02, $02, $02, $02, $02
        .byte $02, $02, $02, $02, $02, $02, $02, $02, $02
        .byte $41, <CDL2, >CDL2
;------------------------
LINE     .byte $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
         .byte $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
;------------------------
;------------------------
STAT    .byte 0,   0
        .byte 26,  0
        .byte 17,  1
        .byte 30,  1
        .byte 16,  2
        .byte 24,  3
        .byte 28,  4
        .byte  5,  4
        .byte 18,  8
        .byte 25,  8
        .byte  6,  9
        .byte 12, 10
        .byte  9,  2
        .byte 14,  5
        .byte  1,  6
        .byte  3, 12
        .byte 26, 12
        
;-------- end TITLE.ASM
;        icl 'inc/languages.asm'
.ENDL