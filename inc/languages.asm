LANGUAGE  .LOCAL
DLIST   .byte $70, $70, $70, $70, $70, $70, $70, $70
        .byte $4A, <SCRN, >SCRN, $00, $0A
        .byte $00, $0A, $00, $0A, $00, $0A, $00, $0A
        .byte $00, $0A, $00, $0A, $f0
        .byte $4c, <TITLE.LINE, >TITLE.LINE, $40, $42
        .byte <(SCRN+128), >(SCRN+128), $02, $02, $02
        .byte $40, $4c, <TITLE.LINE, >TITLE.LINE, $41, <DLIST, >DLIST

TEXT    .byte "             POLSKI             "
        .byte "             MAGYAR             "
        .byte "             ENGLISH            "
        .byte "             DEUTSCH            "
        
CHOOSE:
        jsr TITLE.TSETUP
        jsr TITLE.HALT
        
        lda <DLIST
        sta SDLSTL
        lda >DLIST
        sta SDLSTH

        lda #33
        sta SDMCTL

        jsr TITLE.CLS
        
        ldx #128
cloop:  lda TEXT,x
        sta SCRN+128,x
        dex
        bpl cloop
        
        lda #0
        sta LANG_HLP
        sta RTCLOKL
;---------------------------------------
main:
        jsr TITLE.BIGR
        
        lda <(SCRN+128+11)
        sta DST_PTR
        lda >(SCRN+128+11)
        sta DST_PTR+1
        
        lda #0
        tay
        sta (DST_PTR),y
        ldy #32
        sta (DST_PTR),y
        ldy #64
        sta (DST_PTR),y
        ldy #96
        sta (DST_PTR),y
        
        lda LANG_HLP
        asl
        asl
        asl
        asl
        asl
        tay

        lda #$5f
        sta (DST_PTR),y
        
        lda RTCLOKL
        lsr
       and #3
        bne nodown
        lda JOY0
        and #3
        cmp #2
        bne noup
        lda LANG_HLP
        cmp #0
        beq nodown
        dec LANG_HLP
        lda #$04
        jsr SOUND.SOUND_        

        jmp nodown
noup:   cmp #1
        bne nodown
        lda LANG_HLP
        cmp #3
        bpl nodown
        inc LANG_HLP
        lda #$04
        jsr SOUND.SOUND_        

nodown:        
        jsr TITLE.HALT
        
        ldx #59
        lda #$0e
        jsr TITLE.WLIN

        lda TRIG0
        bne main
        lda #$05
        jsr SOUND.SOUND_        

        rts
        
.ENDL