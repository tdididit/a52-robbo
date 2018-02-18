GAME      .LOCAL
;-------- R1.ASM

CVDL    .byte $40, $70, $70, $F0, $64
DLSA    .byte <SCRN, >SCRN, $24, $24
        .byte $24, $24, $24, $24, $24, $24, $24, $24
        .byte $24, $24, $24, $24, $24, $24, $24, $24
        .byte $24, $84, $30, $30, $42
DLLA    .byte <RAM_INFO, >RAM_INFO, $02 ; zmieniæ na RAM_INFO
        .byte $00, $41
        .byte <RAM_CVDL, >RAM_CVDL ; zmieniæ na RAM_CVDL
        
INFO:   .byte $00, $00, $0b, $0b, $0b, $0b, $0b, $0b
        .byte $00, $00, $4d, $4e, $0b, $0b
        .byte $00, $00, $49, $4a, $0b, $0b
        .byte $00, $00, $55, $56, $0b, $0b
        .byte $00, $00, $51, $52, $0b, $0b
        .byte $00, $00, $45, $46, $0b, $0b
        .byte $00, $00
        .byte $00, $00, $01, $01, $01, $01, $01, $01
        .byte $00, $00, $4f, $50, $01, $01
        .byte $00, $00, $4b, $4c, $01, $01
        .byte $00, $00, $57, $58, $01, $01
        .byte $00, $00, $53, $54, $01, $01
        .byte $00, $00, $47, $48, $01, $01
        .byte $00, $00
DINF    .byte "QB PARTY 2016 DEMO VERSION              "
;DINF    .byte "DOWNLOAD CONTENT DEMO VERSION           "
;DINF    .byte "DOWNLOAD CONTENT FULL VERSION           "
;DINF    .byte "CARTRIDGE VERSION                       "

CVDL_SIZE = *-CVDL
DLSA_OFFSET = DLSA-CVDL
DLLA_OFFSET = DLLA-CVDL
INFO_OFFSET = INFO-CVDL
DINF_OFFSET = DINF-CVDL

RAM_DLSA = RAM_CVDL + DLSA_OFFSET
RAM_DLLA = RAM_CVDL + DLLA_OFFSET
RAM_INFO = RAM_CVDL + INFO_OFFSET
RAM_DINF = RAM_CVDL + DINF_OFFSET
        
PLAY:
pipa:   lda #0
        sta SDMCTL
        sta VSF
        sta SCOR
        sta SCOR+1
        sta SCOR+2
        jsr TITLE.HALT
        jsr CHNMON
        
        lda #$0f
        sta X_POS
pipa1:
        lda #$1f
        sta Y_POS
pipa2:
        lda #$13
        jsr PUT_
        dec Y_POS
        bpl pipa2
        dec X_POS
        bpl pipa1
        stx LSTE
setup:  jsr TITLE.HALT
        lda >FONT_RAM
        sta SCHBASE
        lda <RAM_CVDL
        sta SDLSTL
        lda >RAM_CVDL
        sta SDLSTH
        
setu1:  lda VSF
        bne setu1
             
        lda <SCRN
        sta RAM_DLSA
        sta FADR
        lda >SCRN
        sta RAM_DLSA+1
        sta FADR+1
        
        lda #0
        sta NMIEN
        lda <DLI
        sta VDLI
        lda >DLI
        sta VDLI+1
        lda #$c0
        sta NMIEN
;*-----------------
PLA1:   lda #$ff
        jsr SOUND.SOUND_
        
        lda DEMO
        beq plaj1
        lda #3          ; czas demo
        sta CDTMR2
plaj1:
        lda <RAM_INFO
        sta RAM_DLLA
        lda >RAM_INFO
        sta RAM_DLLA+1
        lda #$02
        ldx DEMO
        beq plaj2
        ora #$80
plaj2:
        sta RAM_DLLA+2
        lda DEMO
        beq plaj3
        lda #$02
plaj3:
        sta RAM_DLLA+3

        jsr UNPACK_CAVE
;* kolory, srubki...
        
        lda CAPA+1
        sta ZEBR
        
        ldx #4
plaj4:
        lda CAPA+2,x
        sta COLOR0,x
        dex
        bpl plaj4
        
        
        lda CAPA+7
        sta PCOLR3
        
        lda #$ff
        ldx #8
plaj5:
        sta SIZEP0,x
        dex
        bpl plaj5
        
        lda #$40
        sta HPOSP0
        lda #$60
        sta HPOSP1
        lda #$80
        sta HPOSP2
        lda #$a0
        sta HPOSP3
        
        lda #$04
        sta PRIOR
        
        ldx #1
        stx TELE
        dex
        stx KEYS
        stx NABO
        stx RUCH
        
        lda #%1101
        sta LM
        
                
        lda #33
        sta SDMCTL
        jsr TITLE.HALT

        jsr ENTCV

        
;* play loop

PCLO:   
;        jsr wait_trig
        lda #0
        sta FAC
        jsr CHNGCV
        
        lda TELE
        beq plo1
        sta FAC
plo1:        
        lda DEMO
        beq plo3
        lda FAC
        beq ZYTY
        jsr TETR
        bne plo2
        ldx #16
        jsr TITLE.WAIT
                
        jmp TITLE.TITLE
plo2:
        lda CDTMR2
        bne PCLO
        beq NXCV
plo3:   lda SKSTAT
        cmp #$fb
        bne PL1
        lda STIMER
        nop
        nop
        nop
        nop
        cmp #$1c
        beq ZYTY
PL1:    lda FAC
        bmi NXCV
        bne PCLO

;* zabity

ZYTY:   lda #0
        sta RUCH
        sta RTCLOKL
        sta CDTMR2
        
        jsr WYBC
        
        lda DEMO
        bne NXCV
        
        sed
        lda LIVS
        sec
        sbc #1
        sta LIVS
        cld
        bcs zyty1
        inc LIVS
        
        jmp TITLE.TITLE
zyty1:  jmp PLA1

;* nxtcv
                
NXCV:   lda #15
        sta X_POS

nxcv1:        
        lda #0
        sta RUCH
        
        lda #31
        sta Y_POS 
nxcv2:   
        lda #$13
        jsr PUT_
        dec Y_POS
        bpl nxcv2
        jsr CHNMON
        lda X_POS
        lsr
        bcc nxcv3
        inc CNTR
nxcv3:  ldx #1
        jsr TITLE.WAIT    
        
        dec X_POS
        bpl nxcv1
        
        lda CNUM
        cmp #55
        bcc nxcv5
        ldx DEMO
        beq nxcv4
        lda #0
        sta RTCLOKL
        jmp TITLE.TITLE
nxcv4:  jmp TITLE.CONGR
nxcv5:  
        cmp #15
        bcc nxcv6
        nop
;        jsr LOAD
nxcv6:  inc CNUM
        jmp PLA1
        
;* wybu komnate

WYBC:   jsr WHILE

        lda #0
        jsr SOUND.SOUND_
        
        lda #31
        sta Y_POS

wbc1:        
        lda #15
        sta X_POS
WBC2:   jsr TST_
        and #$7f
        cmp #$20
        beq WBC3        
        cmp #$13
        beq WBC3
        cmp #$11
        beq WBC3
        cmp #$05
        beq WBC3
        LDA RANDOM
        and #3
        adc #$61
        ldy #$00
        sta (ADDR),y
WBC3:   dec X_POS
        bpl WBC2
        dec Y_POS
        bpl wbc1
WHILE:  
        lda #$30
        sta CDTMR2+1
        
whil: 
        jsr CHNGCV
        lda CDTMR2+1
        bne whil
        rts
        
LOAD:   rts

CHNGCV:
        lda CDTMR1+1
        bne CHNGCV
        
        lda #7
        sta CDTMR1+1
        inc CNTR
        
        ldy #$00
        sty Y1
chca1:  ldx #$00
        stx X1
CHC1:   lda X1
        sta X_POS
        lda Y1
        sta Y_POS
        jsr TST_
        tay
        asl
        bcs NOR_
        cpy #$61
        bcs NXT_
        tay
        lda PROC,y
        ldx PROC+1,y
        beq CHCC
        sta inflate_rom.CALL+1
        stx inflate_rom.CALL+2

;* niemiganie
chca2:        
        lda VCOUNT
        cmp #93
        bcc chca2
        
        jmp inflate_rom.CALL
        
;* normalny elem
NOR_:   cpy #$a0
        beq CHCC
        tya
        and #$7f
        jsr PUT_
        jmp CHCC
        
;* nastêpny elem
NXT_:   cpy #$7b
        bcs CHCC
        
        tya
        cmp #$6d
        bne NXXX
        ldy #$0
        sty TELE
        iny
        sty FAC
        
NXXX:   sec
        sbc #$61
        tax
        lda NEXT,x
        jsr PUT_
        
;* ----
CHCC:   inc X1
        lda X1
        cmp #16
        bcs chcc1
        jmp CHC1
chcc1:        
        inc Y1
        lda Y1
        cmp #31
        bcs chcc2
        jmp chca1
chcc2:  jmp CHNMON    
        rts  
        
;***********************        

ENTCV:
        lda CNUM
        asl
        asl
        and #$f0
        clc
        adc #$0f
        tax
        ldy #$0f
entcv1:
        lda MFNT,x
        sta FONT_RAM,y
        lda MFNT+$0100,x
        sta FONT_RAM+$0100,y
        dex
        dey
        bpl entcv1
        
;* display

        ldx #$0f
        stx X_POS
        ldy #$1f
        sty Y_POS
entcv2: 
        lda #$13
        jsr PUT_
        dec X_POS
        bpl entcv2
        lda #$10
        sta X_POS
entcv3: lda #$00
        sta Y_POS
DSC1:   jsr TST_
        cmp #$2a
        bne entcv4
        jsr MFX1
;        dec Y_POS
        lda #$1b
entcv4: 
        cmp #$2b
        bne entcv5
        ldx CNUM
        cpx LSTE
        bne entcv5
        lda #$E1
entcv5: 
        jsr PUT_
        inc Y_POS
        lda Y_POS
        cmp #$1f
        bcc DSC1
        jsr CHNMON
        lda X_POS
        lsr
        bcc entcv6
        inc CNTR
entcv6: ldx #$01
        jsr TITLE.WAIT
        dec X_POS
        bpl entcv3           
        rts

CHNMON:
        jsr TITLE.HALT
        
        lda #0
        sta ADDR
        lda CNTR
        clc
        and #2
        adc >SFNT
        sta ADDR+1
        
        ldy #$ff
CM1:    lda (ADDR),y
        sta FONT_RAM,y
        inc ADDR+1
        lda (ADDR),y
        sta FONT_RAM+$0100,y
        dec ADDR+1
        dey
        cpy #$df ;#255-32
        bne CM1
        
        ldx #$af; #175
CM2:    lda (ADDR),y
        sta FONT_RAM,x
        INC ADDR+1
        lda (ADDR),y
        sta FONT_RAM+$0100,x
        dec ADDR+1
        dey
        dex
        cpx #$4f; #175-96
        bne CM2
        
        lda NOGA_HLP
        clc
        and #1
        asl
        adc >SFNT
        sta ADDR+1
        
        ldx RUCH
        beq FA1
        ldx FAC
        beq FA1
        inc NOGA_HLP
        
;        ldx #$50; #80
;cm21:    lda PLAY,x
;        sta CONSOL
;        dex
;        bpl cm21
        
FA1:    lda LM
        ldy #4
fa11:
        dey
        lsr
        bcs fa11
        
        tya
        asl
        asl
        asl
        asl
        adc #$4f; #79
        tay
        
        ldx #$0f
CM3:    lda (ADDR),y
        sta FONT_RAM+$02f0,x
        inc ADDR+1
        lda (ADDR),y
        dec ADDR+1
        sta FONT_RAM+$03f0,x
        dey
        dex
        bpl CM3
        
        rts
;****************************

RT_:    inc X_POS
        jsr TST_
        beq rt1
        dec X_POS
        sec
        rts    
rt1:    dec X_POS
        jsr GET_
        inc X_POS
        ora #$80
        jsr PUT_
        clc
        rts
LT_:    dec X_POS
        jsr TST_
        beq lt1
        inc X_POS
        sec
        rts    
lt1:    inc X_POS
        jsr GET_
        dec X_POS
        jsr PUT_
        clc
        rts
DW_:    inc Y_POS
        jsr TST_
        beq dw1
        dec Y_POS
        sec
        rts
dw1:    dec Y_POS
        jsr GET_
        inc Y_POS
        ora #$80
        jsr PUT_
        clc
        rts
UP_:    dec Y_POS
        jsr TST_
        beq up1
        inc Y_POS
        sec
        rts
up1:    inc Y_POS
        jsr GET_
        dec Y_POS
        jsr PUT_
        clc
        rts
FD_:    lda LM
        ldx #$ff
fd1:    inx
        lsr
        bcs fd1
        lda LMVT,x
        sta inflate_rom.JMP1+1
        lda LMVT+4,x
        sta inflate_rom.JMP1+2
        jmp inflate_rom.JMP1
LMVT    .byte <UP_, <DW_, <LT_, <RT_
        .byte >UP_, >DW_, >LT_, >RT_
        
T_LT:   dec X_POS
        jsr TST_
        inc X_POS
        jmp T_EX
T_RT:   inc X_POS
        jsr TST_
        dec X_POS
        jmp T_EX
T_UP:   dec Y_POS
        jsr TST_
        inc Y_POS
        jmp T_EX
T_DW:   inc Y_POS
        jsr TST_
        dec Y_POS  ;<---------
T_EX:   cmp #$a0
        bne tex1
        lda #$00
tex1:   and #$7f
        tax
        lda WHAT,x
        rts
TETR:
        lda TRIG0
        
        rts     
;* pojawiaj
WFAC:   lda VSF
        beq wfa1
        rts
wfa1:   jsr TITLE.HALT
        lda VSF
        beq wfa2
        rts
wfa2:   lda #$0b
        jsr SOUND.SOUND_
        lda #$6a
        jmp PUT_
;* ruch
MFAC:   lda TELE
        cmp #1
        bne mfa1
        dec TELE
mfa1:   lda #1
        sta FAC
        
        dec STRC
        bpl mfa2
        inc STRC
mfa2:        
        lda DEMO
        beq mfa3
        lda RANDOM
        and #$0f
        beq mfa4
mfa3:
;        jsr TETR
        lda TRIG0
        and #1
        beq mfa4
        jmp MFC1
mfa4:
;* strzelaj
        lda #0
        sta RUCH
        
        lda STRC
        cmp #$ff
        bne strz0
        lda #0
        sta STRC
;        jmp strz1  
strz0:  lda STRC
        beq strz1
        rts
        
strz1:  lda DEMO
        beq strz2
        lda LM
        bpl strz3
strz2:
;        jsr KEJO
;        and JOY0
        lda JOY0
strz3:
        cmp #$0f
        bne strz4
        rts
strz4:  sta LM
        
        ldx NABO
        bne strz5
        inc NOGA_HLP
        rts
strz5:  
        pha
        sed
        sec
        lda NABO
        sbc #1
        sta NABO
        cld
        pla
        
        ldx #6
        stx STRC
        
        ldx #$ff
KIES:   inx
        lsr
        bcs KIES
        cpx #4
        bcc kie1
        rts
kie1:         
        txa
        asl
        tax
        lda KIET,x
        sta inflate_rom.SJMP+1
        lda KIET+1,x
        sta inflate_rom.SJMP+2
        
        jsr inflate_rom.SJMP
        lda #$01
        jmp SOUND.SOUND_
        
KIET    .word PP1U, PP1D, PP1L, PP1R

;*key to joy
KEJO:   
        lda JOY0
        and #$3f
        tax                               
;        lda SKSTAT
;        lsr 
;        lsr
;        lsr
        lda RTCLOKL
        lsr
        and #1
        beq kejo1
        rts
kejo1:  stx JOY0+1
        cpx #$0e
        bne kejo2
        lda #%1110
kejo2:
        cpx #$0d ;0f  
        bne kejo3
        lda #%1101
kejo3:  
        cpx #$0b ;06
        bne kejo4
        lda #%1011
kejo4:  
        cpx #$07
        bne kejo5
        lda #%0111
kejo5:
        clc
        rts
;***********************
MFC1:   ldx DEMO
        beq M1
        
        lda RUCH
        beq mfc11

        lda RANDOM
        and #15
        bne mfc12         

mfc11:        
        lda RANDOM
        and #3
        tax
        lda TMVS,x
        bpl M2
mfc12:  lda LM
        bpl M2
M1:     ;jsr KEJO
        lda JOY0
;        and JOY+1
        
M2:     cmp #$0f
        beq mfc13
        sta LM
mfc13:  ldx #1
        stx RUCH
        
        lsr 
        bcc MFUP
        lsr
        bcc MFDW
        lsr
        bcc MFLT
        lsr
        bcc MFRT
        
        bcs MFX1

MFLT:   jsr LT_
        bcc MFEX
        dec X_POS
        jmp PHAJ
        
MFRT:   jsr RT_
        bcc MFEX
        inc X_POS
        bcc MFUP
        jmp PHAJ

MFUP:   jsr UP_
        bcc MFEX
        dec Y_POS
        bcs PHAJ
 
MFDW:   jsr DW_
        bcc MFEX
        inc Y_POS
        bcs PHAJ
;*********************                       
MFX1:   lda #0
        sta RUCH
MFEX:   jsr TST_
        jsr PUT_
        lda SCRA
        sta FADR
        lda SCRA+1
        sta FADR+1
        
        lda X_POS
        sta FX
        lda Y_POS
        sta FY
        
        ldx TELE
        dex
        bne mfex1
;* stworek ?        
        jsr T_UP
        jsr TSTW
        jsr T_DW
        jsr TSTW
        jsr T_LT
        jsr TSTW
        jsr T_RT
        jsr TSTW
mfex1:
;* tst magnes
        jsr TST_
        
        ldy #0
mfex2:
        iny
        lda (ADDR),y
        cmp #$20
        beq mfex2
        
        cmp #$29
        beq mfex3
        rts
mfex3:
        lda #1
        sta FAC
        
        lda #$8c
        jsr PUT_
        
        lda #$0e
        jmp SOUND.SOUND_
;* tst stworek
TSTW:   cpx #$41
        bcc tstw1
        cpx #$4f
        bcc tstw2
tstw1:  rts
tstw2:  pla
        pla
        
        lda #$0a
        jsr SOUND.SOUND_
        
        lda #$61
        jmp PUT_
;* pchaj ?
PHAJ:   cmp #$0e
        beq PHA1
        cmp #$0d
        beq PHA1
        cmp #$3f
        beq PHA1
        cmp #$23
        beq PHA1
        cmp #$14
        beq PHA1
        cmp #$40
        bne TTPO
PHA1:
        jsr FD_
        ldx #0
        bcs pha2
        lda #$08
        jsr SOUND.SOUND_
        ldx #1
pha2:
        stx RUCH
        lda X1
        sta X_POS
        lda Y1
        sta Y_POS
        jsr FD_
        jmp MFEX
;* czy teleport?
TTPO:   
        cmp #$30
        bcs ttpo1
ttp0:   jmp TKEY
ttpo1:  cmp #$3a
        bcs ttp0
ttpo2:
        sta TELE
        ora #$80
        jsr PUT_
        lda X1
        sta X_POS
        lda Y1
        sta Y_POS
        lda #$03
        jsr SOUND.SOUND_
        
        lda #0
        sta RUCH
        
        lda #$64
        jmp PUT_
;* wyj z teleportu
TELP:   jsr TST_
        cmp TELE
        beq telp1
        rts  
telp1:
        lda #$69
        jsr PUT_
        jsr FD_
        bcc WYSE
        
        lda LM
        pha
        ldy #0
telp2:
        iny
        lsr
        bcs telp2
        tya
        asl
        asl
        tay
        dey
        
WYCP:   tya
        pha
        lda TMVS,y
        sta LM
        jsr FD_
        pla
        tay
        bcc wycp1
        dey
        bpl WYCP
        
        pla
        sta LM
        lda TELE
        jmp PUT_
        
wycp1:  pla
        sta LM
WYSE:   jsr MFX1
        lda X1
        sta X_POS
        lda Y1
        sta Y_POS
        lda TELE
        ldx #1
        stx TELE
        jmp PUT_
        
TMVS    .byte $D, $B, $7, $E, $E, $7, $B, $D
        .byte $7, $E, $D, $B, $B, $D, $E, $7
;* klucz ?

TKEY:   cmp #$3d
        bne TDOR
        
        sed
        clc
        lda KEYS
        adc #1
        sta KEYS
        cld
        
        ldx #$00
        lda #$75
        jsr ASCO
        
        lda #$09
        jsr SOUND.SOUND_
        
FGET:   jsr GET_
fget1:
        lda X1
        sta X_POS
        lda Y1
        sta Y_POS
        jsr FD_
        jmp MFEX
        
;* drzwi ?

TDOR:   ldx KEYS
        beq TSKA
        
        cmp #$7c
        beq tdor1
        cmp #$12
        bne TSKA
tdor1:  sed
        sec
        lda KEYS
        sbc #1
        sta KEYS
        cld
        
        ldx #1
        lda #0
        jsr ASCO
        
        lda #$06
        jsr SOUND.SOUND_
        
        lda #$7a
        jmp PUT_
;* skarb ?

TSKA:   cmp #$24
        bne TWYJ
        
        lda ZEBR
        bne tska1
        lda #$0d
        jsr SOUND.SOUND_
        jmp NXCV
tska1:        
        lda ZEBR
        bne tska2
        ldx #2
        lda #$50
        bne tska3        
tska2:  sed
        sec
        lda ZEBR
        sbc #1
        sta ZEBR
        cld
        ldx #1
        lda #0
tska3:  jsr ASCO
        lda #$04
        jsr SOUND.SOUND_
        jmp FGET
;* wyjscie ?
TWYJ:   cmp #$15
        beq twyj1
        cmp #$16
        bne TNAB
twyj1:
        lda X1
        sta X_POS
        lda Y1
        sta Y_POS
        lda #$20
        jsr PUT_
        
        ldx #$10
        lda #$00
        jsr ASCO
        lda #$0c
        jsr SOUND.SOUND_
        
        lda #$80
        sta FAC
        rts
;* naboje?
TNAB:   cmp #$21
        bne TEXL
        sed
        clc
        lda #$09
        adc NABO
        bcc tnab1
        lda #$99
tnab1:  sta NABO
        cld
        ldx #$00
        lda #$50
        jsr ASCO
        
        lda #$07
        jsr SOUND.SOUND_
        
        jmp FGET
;* extra life?
TEXL:   cmp #$2b
        bne TBEZ
        lda CNUM
        sta LSTE
        sed
        clc
        lda #1
        adc LIVS
        sta LIVS
        cld
        
        ldx #2
        lda #0
        jsr ASCO
        
        lda #$05
        jsr SOUND.SOUND_
        
        jmp FGET
        
;* bezw skrzynia ?

TBTAB   .byte $09, $8a, $07, $88
TBEZ:   cmp #$06
        bne ENDT
        jsr FD_
        bcs ENDT
        ldx #$ff
        lda LM
tbez1:
        inx
        lsr
        bcs tbez1
        lda TBTAB,x
        jsr PUT_
        lda #$08
        jsr SOUND.SOUND_
        
        jmp fget1
;***************************

ENDT:   lda FX
        sta X_POS
        lda FY
        sta Y_POS
        jmp MFX1
        
NIES:   lda RANDOM
        and #$1f
        tax
        lda NSPS,x
        beq nies1
        jmp PUT_
nies1:
        lda #$2b
        jsr PUT_
        lda #$1e
        sta Y_POS
nies2:
        lda #$0f
        sta X_POS
SUP1:   jsr TST_
        and #$7f
        tax
        
        lda #$a0
        cpx #$28
        beq SUP2+2
        cpx #$29
        beq SUP2+2
        cpx #$7c
        beq SUP2
        cpx #$12
        beq SUP2
        cpx #$26
        beq SUP2
        cpx #$41
        bcc SUP2+5
        cpx #$4d
        bcc SUP2+5
SUP2:   lda #$e1
        jsr PUT_
        dec X_POS
        bpl SUP1
        dec Y_POS
        bpl nies2
        ldx #5
        lda #0
        jsr ASCO
        lda #$0d
        jmp SOUND.SOUND_

NSPS    .byte $00,$00,$3F,$3F,$21,$21,$21,$21
        .byte $3D,$3D,$3D,$24,$24,$24,$24,$24
        .byte $26,$26,$40,$2B,$2B,$2B,$2B,$2B
        .byte $63,$63,$15,$2C,$2E,$2D,$2F,$23
;* dodaj punkty
ASCO:   sed
        clc
        adc SCOR+2
        sta SCOR+2
        
        txa
        adc SCOR+1
        sta SCOR+1
        
        lda #0
        adc SCOR
        sta SCOR
        cld
        rts
;* bezw skzynie ------------
BEZL:   jsr LT_
        bcc BEZX
        jsr BEZS
        jmp PP1L
        
BEZR:   jsr RT_
        bcc BEZX
        jsr BEZS
        jmp PP1R
        
BEZU:   jsr UP_
        bcc BEZX
        jsr BEZS
        jmp PP1U
        
BEZD:   jsr DW_
        bcs bezx1
BEZX:   lda #8
        jmp SOUND.SOUND_
bezx1:  jsr BEZS
        jmp PP1D
        
BEZS:   lda #$06
        jmp PUT_
        
;* losowy powrót

RNDR:   lda RANDOM
        cmp #$12
        bcc rndr1
        pla
        pla
rndr1:  rts

;* bomba -------------------
BOMB:   lda #0
        jsr SOUND.SOUND_
        
        dec X_POS
        dec Y_POS
        jsr TST_
        
        ldx #8
BOM1:   lda WBPO,x
        tay
        lda (ADDR),y
        cmp #$A0
        beq BOM2
        and #$7f
        tay
        cpx #4
        beq BOM0
        lda WHAT,y
        and #%10
        beq BOM2
BOM0:        
        tya
        pha
        lda WBPO,x
        tay
        pla
        cmp #$40
        bne bom01
        dec Y_POS
        lda #$e0
        bne bom02
bom01:  lda WBPO+9,x
bom02:  sta (ADDR),y
BOM2:
        dex
        bpl BOM1
        inc X_POS
        inc Y_POS
        jmp TST_
        
WYBO:   
        lda #$60    
        jmp PUT_
WBPO:   .byte $00,$01,$02,$10,$11,$12,$20,$21
        .byte $22
        .byte "ababcbaba"                        
;* put wyb-spac
PUTW:   
        tax
        lda #$20
        cpx #$5d
        beq putw1
        cpx #$5b
putw1:
        beq putw2

        lda #$66
putw2:
        jmp PUT_
  

;* magnes
MGNL:   lda FY
        cmp Y_POS
        beq mgn0
        rts
mgn0:   ldy #0
MGN1:   iny
        lda (ADDR),y
        cmp #$20
        beq MGN1
        and #$7f
        cmp #$2a
        beq mgn2
        rts
mgn2:   lda #$8b
        sta (ADDR),y
        lda #1
        sta FAC
        lda #$0e
        jmp SOUND.SOUND_
MGFL:   lda #1
        sta FAC
        jsr LT_
        bcs PRZY
        rts
PRZY:    lda #$76
        jsr PUT_
        lda #00
        sta FAC
        
        lda #$0a
        jmp SOUND.SOUND_
MGFR:    
        lda #1
        sta FAC
        jsr RT_
        bcs PRZY
        rts
;*dzia³o
;* 1L
DZ1L:   jsr RNDR
        lda #1
        jsr SOUND.SOUND_
        jmp PP1L
PO1L:   jsr LT_
        bcs po1l1
        rts
po1l1:        
        jsr PUTW
        
PP1L:   jsr T_LT
        dec X_POS
        cpx #$20
        beq pp1l1
        cpx #$5d
        bne PPP1
pp1l1:        
        lda #$4f
        jmp PUT_
PPP1:
        lsr
        bcs ppp11
        lda #$02
        jmp SOUND.SOUND_
ppp11:        
        cpx #$40
        bne ppp12
        jmp WYBO
ppp12:        
        cpx #$3f
        bne ppp13
        jmp PUNIES
ppp13:        
        lda #$0a
        jsr SOUND.SOUND_
        
        lda #$61
        jmp PUT_
        
;* 1R

DZ1R:   jsr RNDR
        lda #$01 
        jsr SOUND.SOUND_
        jmp PP1R
        
PO1R:   jsr RT_
        bcs po1r1
        rts
po1r1:        
        jsr PUTW  
PP1R:   jsr T_RT
        inc X_POS
        cpx #$20        
        beq pp1r1
        cpx #$5d
        bne PPP1
pp1r1:        
        lda #$d0
        jmp PUT_
        
;* 1U
DZ1U:   jsr RNDR
        lda #1
        jsr SOUND.SOUND_
        jmp PP1U
PO1U    jsr UP_
        bcs po1u1
        rts
po1u1:        
        jsr PUTW
        
PP1U:   jsr T_UP
        dec Y_POS
        cpx #$20
        beq pp1u1
        cpx #$5b
        bne PPP1
pp1u1:        
        lda #$51 
        jmp PUT_
               
;* 1D

DZ1D:   jsr RNDR
        lda #1
        jsr SOUND.SOUND_
        jmp PP1D
PO1D:   jsr DW_
        bcs po1d1
        rts
po1d1:        
        jsr PUTW
PP1D:   jsr T_DW
        inc Y_POS
        cpx #$20
        beq pp1d1
        cpx #$5b
        beq pp1d1
        jmp PPP1
pp1d1:        
        lda #$d2
        jmp PUT_
        
;* laser ---------------------                                

DZ2L:   jsr RNDR
        jmp PP2L
PO2L:   jsr LT_
        bcs po2l1
        inc X_POS
        lda #$5d
        jmp PUT_
po2l1:        
        lda #$50
        jsr PUT_
PP2L:   jsr T_LT
        dec X_POS
        cpx #$20
        bne PPP2
        
        lda #$53
        jmp PUT_
        
PPP2:   lsr
        bcs ppp21
        lda #2
        jmp SOUND.SOUND_
ppp21:        
        cpx #$40
        bne ppp22
        jmp WYBO
ppp22        
        cpx #$3f
        bne ppp23
        jmp PUNIES
ppp23:        
        lda #$0a
        jsr SOUND.SOUND_
        
        lda #$61
        jmp PUT_
DZ2R:   jsr RNDR
        jmp PP2R
PO2R:
        jsr RT_
        bcs po2r1
        dec X_POS
        lda #$5d
        jmp PUT_
po2r1:        
        lda #$4f
        jsr PUT_
PP2R:   jsr T_RT
        inc X_POS
        cpx #$20
        bne PPP2
        lda #$d4
        jsr PUT_
        rts
DZ2U:   jsr RNDR
        jmp PP2U
        
PO2U:   jsr UP_
        bcs po2u1
        inc Y_POS
        lda #$5b
        jmp PUT_
po2u1:        
        lda #$52
        jsr PUT_
PP2U:   jsr T_UP
        dec Y_POS
        cpx #$20
        bne PPP2
        
        lda #$55
        jmp PUT_
        
DZ2D:   jsr RNDR
        jmp PP2D
PO2D:   jsr DW_
        bcs po2d1
        dec Y_POS
        lda #$5b
        jmp PUT_
po2d1:        
        lda #$51
        jsr PUT_
        
PP2D:   jsr T_DW
        inc Y_POS
        cpx #$20
        beq pp2d1
        jmp PPP2
pp2d1        
        lda #$d6
        jsr PUT_
        rts
;* blaster
DZ3L:   jsr RNDR 
        jmp PP3L
PO3L:
        jsr LT_
        bcs po3l1
        jsr D3TB
        inc X_POS
po3l1
        lda #$62
        jmp PUT_
        
PP3L:   jsr T_LT
        dec X_POS
        cpx #$20
        beq pp3l1
        
        lsr
        bcs pp3l1
        rts
pp3l1:        
        jsr D3TB
        
        lda #$57
        jmp PUT_
        
DZ3R:   jsr RNDR
        jmp PP3R
PO3R:   jsr RT_
        bcs po3r1
        jsr D3TB
        dec X_POS
        lda #$62
        jmp PUT_
po3r1:        
        lda #$62
        jsr PUT_
PP3R:
        jsr T_RT
        inc X_POS
        cpx #$20
        beq pp3r1
        lsr
        bcs pp3r1
        rts
pp3r1:        
        jsr D3TB
        lda #$d8
        jmp PUT_
DZ3U:
        jsr RNDR
        jmp PP3U
PO3U:   jsr UP_
        bcs po3u1
        jsr D3TB
        inc Y_POS
        lda #$62
        jmp PUT_
po3u1:        
        lda #$62
        jsr PUT_
PP3U:
        jsr T_UP
        dec Y_POS
        cpx #$20
        beq pp3u1
        lsr
        bcs pp3u1
        rts
pp3u1:        
        jsr D3TB
        lda #$59
        jmp PUT_
DZ3D: 
        jsr RNDR
        jmp PP3D
PO3D:   jsr DW_
        bcs po3d1
        jsr D3TB
        dec Y_POS
        lda #$62
        jmp PUT_
po3d1:        
        lda #$62
        jsr PUT_
PP3D:   jsr T_DW
        inc Y_POS
        cpx #$20
        beq pp3d1
        lsr
        bcs pp3d1
        rts
pp3d1:        
        jsr D3TB
        lda #$da
        jmp PUT_
;* dz3 test bomba
D3TB:
        cpx #$3f
        beq PUNIES
        
        cpx #$40
        bne d3tb1
        pla
        pla
        jmp WYBO
d3tb1:        
        rts
;* put niespodzianka
PUNIES:             
        lda #$0a
        jsr SOUND.SOUND_
        lda #$6e
        jmp PUT_
        
;* ruch dzia³o
DZRU:   lda CNTR
        and #3
        bne RDZ1
        lda RANDOM
        and #3
        bne RDZ1
        
        jsr GET_
        
        lsr RANDOM
        bcs RDZL
        adc #1
        cmp #$30
        bcc dzru1
        lda #$2c
dzru1:        
        jmp PUT_
        
RDZL:   sbc #1
        cmp #$2c
        bcs rdzl1
        lda #$2f
rdzl1:  jmp PUT_
RDZ1:   lda RANDOM
        and #7
        beq rdz11
        rts
rdz11:        
        jsr TST_
        sec
        sbc #$2c
        asl
        tax
        lda RDZP+1,x
        pha
        lda RDZP,x
        pha
        rts
RDZP    .word PP1R-1,PP1D-1,PP1L-1,PP1U-1

;* mov dzia³a

MODL:   lda CNTR
        lsr
        bcc MOD1
        
        jsr LT_
        bcc MOD1
        
        lda #$0d
        jsr PUT_
        jmp MOD1

MODR:   lda CNTR
        lsr
        bcc MOD1
        
        jsr RT_
        bcc MOD1
        
        lda #$0e
        jsr PUT_
MOD1:   jmp DZ1U

;* zapora

ZAPO:   jsr TST_
        ldy #1
        lda (ADDR),y
        cmp #$0f
        beq zapo1
        lda #$20
zapo1:        
        pha
        jsr TST_
MOZA:
        iny
        inc X_POS
        lda (ADDR),y
        cmp #$0f
        bne MOZ1
        
        dec X_POS
        dey
        beq MOZ2
        lda #$0f
        sty HLP
        jsr PUT1
        ldy HLP
MOZ2:
        iny
        inc X_POS
        lda #$20
        sty HLP
        jsr PUT1
        ldy HLP
MOZ1:
        lda (ADDR),y
        cmp #$05
        bne MOZA
        pla
        dey
        dec X_POS
        cmp #$0f
        beq moz11
        rts
moz11:        
        sta (ADDR),y
        jmp PUT1                          
;* stworki
;* leworeczne

STWA    jsr TFAC
        jsr LT_
        bcs stwa1
        lda #$44
        jsr PUT_
        jmp TFAC
stwa1:        
        jsr UP_
        bcs stwa2
        jmp TFAC
stwa2        
        lda #$43
        jmp PUT_

STWB:   jsr TFAC
        jsr RT_
        bcs stwb1
        lda #$c3
        jsr PUT_
        jmp TFAC
stwb1:        
        jsr DW_
        bcs stwb2
        jmp TFAC
stwb2:
        lda #$44
        jmp PUT_
        
STWC:   jsr TFAC
        jsr UP_
        bcs stwc1
        lda #$41
        jsr PUT_
        jmp TFAC
stwc1:        
        jsr RT_
        bcs stwc2
        jmp TFAC
stwc2:
        lda #$42
        jmp PUT_
        
STWD:   jsr TFAC
        jsr DW_
        bcs stwd1
        lda #$c2
        jsr PUT_
        jmp TFAC
stwd1:        
        jsr LT_
        bcs stwd2
        jmp TFAC
stwd2:
        lda #$41
        jmp PUT_
;* praworeczne

STWE:   jsr TFAC
        jsr LT_
        bcs *+10
        lda #$47
        jsr PUT_
        jmp TFAC 
        
        jsr DW_
        bcs *+5
        jmp TFAC
        lda #$48
        jmp PUT_
        
STWF:   jsr TFAC
        jsr RT_
        bcs *+10
        lda #$c8
        jsr PUT_
        jmp TFAC
        
        jsr UP_
        bcs *+5
        jmp TFAC
        lda #$c7
        jmp PUT_
        
STWG:   jsr TFAC
        jsr UP_
        bcs *+10
        lda #$46
        jsr PUT_
        jmp TFAC
        
        jsr LT_
        bcs *+5
        jmp TFAC
        lda #$45
        jmp PUT_
        
STWH:   jsr TFAC
        jsr DW_
        bcs *+10      
        lda #$c5
        jsr PUT_
        jmp TFAC
        
        jsr RT_
        bcs *+5
        jmp TFAC
        lda #$46
        jmp PUT_
;* lewo-prawo
STWI:   jsr TFAC
        jsr LT_
        bcs stwi1
        jmp TFAC
stwi1:
        lda #$ca
        jmp PUT_
        
STWJ:   jsr TFAC
        jsr RT_
        bcs stwj1
        jmp TFAC
stwj1:
        lda #$c9
        jmp PUT_
;* gora-dol
STWK:   jsr TFAC
        jsr UP_
        bcs stwk1
        jmp TFAC
stwk1:
        lda #$cc
        jmp PUT_

STWL:   jsr TFAC
        jsr DW_
        bcs stwl1       ;<------------ bcc
        jmp TFAC
stwl1:
        lda #$cb
        jmp PUT_
        
; toperze pif-pafy

TOPL:   jsr TFAC
        jsr LT_
        bcc PIFF
        
        lda #$4e
        jsr PUT_
        jmp PIFF
        
TOPR:   jsr TFAC
        jsr RT_
        bcc PIFF
        
        lda #$4d
        jsr PUT_
        
PIFF:   jsr TFAC
        lda RANDOM
        and #7
        beq piff1
        rts
piff1:
        
        jmp PP1D
;* sledz ---------------
LEDZ:   jsr TFAC
        lsr RANDOM
        bcs SKAC
        
        lda Y_POS
        cmp FY
        beq LEX
        bcc *+8
        jsr UP_
        bcs LEX
        rts
        
        jsr DW_
        bcs LEX
        rts
LEX:    lda X_POS
        cmp FX
        bne LEX1
        
SKAC:   lda RANDOM
        and #$20
        beq skac1
        rts
skac1:        
        lda RANDOM
        and #3
        tax
        lda LM
        pha
        lda TMVS,x
        sta LM
        jsr FD_
        pla
        sta LM
        rts
LEX1:   bcs *+5
        jmp RT_
        jmp LT_
        
;* czy obok jest facet?
TFAC:   jsr T_LT
        cpx #$2a
        bne tfac1
        dec X_POS
        jmp ZABJ
tfac1:        
        jsr T_RT
        cpx #$2a
        bne tfac2
        inc X_POS
        jmp ZABJ
tfac2:        
        jsr T_UP
        cpx #$2a
        bne tfac3
        dec Y_POS
        jmp ZABJ
tfac3:        
        jsr T_DW
        cpx #$2a
        beq tfac4
        rts
tfac4:        
        inc Y_POS
        
ZABJ:   lda #$0a
        jsr SOUND.SOUND_
        
        lda #$61
        jsr PUT_
        lda X1
        sta X_POS
        lda Y1
        sta Y_POS
        rts
;* wyjscie

WYZA:   lda ZEBR
        beq *+3
        rts
        
        lda #$0d
        jsr SOUND.SOUND_
        
        lda COLB
        pha
        lda #$0f
        sta COLB
        jsr TITLE.HALT                                                                                                                                                                              
        jsr TITLE.HALT                                                                                                                                                                              
        jsr TITLE.HALT                                                                                                                                                                              
        pla
        sta COLB
        
        lda #$15
        jmp PUT_
        
WYOT:   lda CNTR
        and #3
        beq *+3
        rts
        
        jsr TST_
        eor #$03
        jmp PUT_        
;------------------------------------------------------------------------------
UNPACK_CAVE:        
        lda CNUM
        asl
;- unpack cave to RAM
        tax
        lda CAVESPTRS,x
        sta inflate_rom.inputPointer
        lda CAVESPTRS+1,x
        sta inflate_rom.inputPointer+1
        
        lda <CAVE
        sta inflate_rom.outputPointer
        lda >CAVE
        sta inflate_rom.outputPointer+1
        
        jsr inflate_rom.inflate
        rts


        
;***************************
;* get element
GET_:
        jsr TST_
        pha
        ldy #0
        lda #$20
        jsr PUT1
        pla
        rts
        
;* put element        
PUT_:   ldx X_POS
        cpx #$10
        bcc pt1
        rts
pt1:    ldy Y_POS 
        cpy #$20
        bcc pt2
        rts
pt2:    pha
        jsr TST_
        pla
        ldy #$00
PUT1:   sta (ADDR),y
        tax
        ldy #0
        lda >SCRN
        lsr 
        lsr
        lsr
        sta SCRA+1
        lda Y_POS
        asl
        asl
        asl
        asl
        rol SCRA+1
        asl
        rol SCRA+1
        asl
        rol SCRA+1
        asl X_POS
        adc X_POS
        sta SCRA
        lsr X_POS
        txa
        and #$7f
        cpx #$a0
        bne pt3
        lda #0
pt3:    tax                  ; $6509
;        jsr wait_trig
        lda LOOK,x
        sta (SCRA),y
        iny
        tax
        inx
        txa
        sta (SCRA),y
        clc
        adc #$1f
        ldy #$20
        sta (SCRA),y
        tax
        inx
        txa
        iny
        sta (SCRA),y
        rts        
                        
TST_:
        lda #0
        sta ADDR+1
        lda Y_POS
        asl
        asl
        asl
        asl
        rol ADDR+1
        ora X_POS
        sta ADDR
        lda >CAVE; #5
        adc ADDR+1
        sta ADDR+1
        
        ldy #$00
        lda (ADDR),y
        cmp #$20
        rts        

LOOK:       .byte $80,$46,$00,$00,$48,$80,$4E,$4E
            .byte $4E,$4E,$4E,$5E,$5E,$CA,$CA,$9E
            .byte $00,$80,$C4,$42,$1A,$1A,$9A,$4C
            .byte $4A,$00,$00,$1A,$4A,$4C,$48,$46
            .byte $40,$56,$00,$CE,$5A,$50,$14,$4C
            .byte $16,$18,$5E,$54,$46,$4C,$48,$4A
            .byte $9C,$9C,$9C,$9C,$9C,$9C,$9C,$9C
            .byte $9C,$9C,$40,$00,$48,$5C,$46,$52
            .byte $58,$0E,$0E,$0E,$0E,$10,$10,$10
            .byte $10,$12,$12,$12,$12,$92,$92,$0C
            .byte $0C,$0A,$0A,$0C,$0C,$0A,$0A,$02
            .byte $02,$02,$02,$0A,$00,$0C,$4A,$00
            .byte $58,$02,$04,$06,$08,$06,$04,$02
            .byte $00,$40,$02,$04,$06,$08,$40,$02
            .byte $04,$06,$08,$06,$04,$02,$5E,$5E
            .byte $00,$00,$C4,$00,$C4,$00,$00,$00


;********************
NEXT:   .byte $62,$63,$64,$65,$66,$67,$20,$00
        .byte $6A,$6B,$6C,$6D,$2A,$6F,$70,$71
        .byte $72,$73,$74,$75,$3A,$77,$61,$00
        .byte $00,$20
;********************
PROC:       .word $0000
            .word DZ3R
            .word $0000,$0000
            .word DZ3L
            .word $0000,$0000
            .word BEZL,BEZR,BEZU,BEZD
            .word MGFL,MGFR,MODR,MODL
            .word $0000,$0000
            .word ZAPO
            .word $0000,$0000
            .word WYZA,WYOT,WYOT,DZ3D
            .word DZ3U
            .word $0000,$0000
            .word WFAC,DZ1U,DZ1D,DZ1L
            .word DZ1R
            .word $0000,$0000,$0000,$0000
            .word $0000,$0000
            .word LEDZ,DZ2D,MGNL
            .word $0000
            .word MFAC
            .word $0000
            .word DZRU,DZRU,DZRU,DZRU
            .word TELP,TELP,TELP,TELP
            .word TELP,TELP,TELP,TELP
            .word TELP,TELP,NIES
            .word $0000
            .word DZ2L
            .word $0000
            .word DZ2R
            .word $0000,$0000
            .word STWA,STWB,STWC,STWD
            .word STWE,STWF,STWG,STWH
            .word STWI,STWJ,STWK,STWL
            .word TOPL,TOPR,PO1L,PO1R
            .word PO1U,PO1D,PO2L,PO2R
            .word PO2U,PO2D,PO3L,PO3R
            .word PO3U,PO3D
            .word $0000,$0000,$0000
            .word DZ2U
            .word $0000
            .word BOMB
;********************
WHAT:       .byte $00,$02,$00,$00,$02,$00,$02,$02
            .byte $02,$02,$02,$00,$00,$02,$02,$03
            .byte $00,$00,$02,$00,$00,$00,$00,$02
            .byte $02,$00,$00,$00,$02,$02,$02,$02
            .byte $03,$03,$00,$02,$02,$03,$03,$02
            .byte $00,$00,$03,$03,$02,$02,$02,$02
            .byte $02,$02,$02,$02,$02,$02,$02,$02
            .byte $02,$02,$02,$00,$02,$02,$02,$03
            .byte $03,$03,$03,$03,$03,$03,$03,$03
            .byte $03,$03,$03,$03,$03,$03,$03,$00
            .byte $00,$00,$00,$00,$00,$00,$00,$00
            .byte $00,$00,$00,$00,$00,$00,$02,$00
            .byte $00,$02,$02,$02,$02,$02,$02,$02
            .byte $02,$02,$02,$02,$02,$02,$02,$02
            .byte $02,$02,$02,$02,$02,$02,$00,$00
            .byte $00,$00,$00,$00,$02,$00,$00,$00

;********************
DLI:    pha

        lda DLI_HLP
        beq DLI1
        cmp #1
        beq DLI2
        
        lda RTCLOKL
        lsr
        lsr
        sta COLPF1
        
        pla
        rti
        
DLI2:   lda COLOR4
        sta COLPM0
        sta COLPM1
        sta COLPM2
        sta COLPM3
        
        sta WSYNC
        lda >IFNT_RAM
        sta CHBASE
        
        lda COLOR4
        sta COLPF2
        lda #$0a
        sta COLPF1
        
        lda #34
        sta DMACTL
        
        inc DLI_HLP
        pla
        rti
        
DLI1:   lda COLB
        sta WSYNC
        sta COLPM0
        sta COLPM1
        sta COLPM2
        sta COLPM3

        inc DLI_HLP
        pla
        rti

;********************
;*      VBLK
;********************
CVBL:
        jsr SOUND.SOUNDV
        
        lda IFNT_RAM+$307
        pha
        ldx #6
mov_ramka:
        lda IFNT_RAM+$300,x
        sta IFNT_RAM+$301,x
        dex
        bpl mov_ramka
        pla
        sta IFNT_RAM+$300

;* display info

        lda CNUM
        inc CNUM
        pha
        lda #0
        sta BDEC
        ldx #7
        sed
dis_info1:
        asl CNUM
        adc BDEC
        sta BDEC
        dex
        bpl dis_info1
        cld
        ldy #$25
        jsr DISPLAY_BYTE
        pla
        sta CNUM 
        
        ldy #$1f
        lda NABO
        jsr DISPLAY_BYTE
        
        ldy #$19
        lda KEYS
        jsr DISPLAY_BYTE
        
        ldy #$13
        lda LIVS
        jsr DISPLAY_BYTE
        
        ldy #$0d
        lda ZEBR
        jsr DISPLAY_BYTE
        
        ldx #$02
        ldy #$07
dis_info2:
        lda SCOR,x
        jsr DISPLAY_BYTE
        dex
        bpl dis_info2 
        
;* players

        lda COLOR4
        sta COLPM0     
        sta COLPM1     
        sta COLPM2     
        sta COLPM3
        lda #0
        sta DLI_HLP
        sta ATRACT
        
;* przesunac ekran?

        lda VSF
        bne SCRL
        
        clc
        lda RAM_DLSA
        adc <128
        tax 
        lda RAM_DLSA+1
        adc >128
        
        cpx FADR
        sbc FADR+1
        bcc CVB1
        
;* set w góre

        lda RAM_DLSA
        cmp <SCRN+1
        lda RAM_DLSA+1
        sbc >SCRN+1
        bcc exitv
        
        lda #$0e
        sta VSC
        lda #$82
        sta VSF
        jmp SCRL
        
CVB1:   clc
        lda RAM_DLSA
        adc <512
        tax
        lda RAM_DLSA+1
        adc >512
        
        cpx FADR
        sbc FADR+1
        bcc CVB2
exitv:            
        rts

;* set w dó³
CVB2:   lda RAM_DLSA
        cmp <SCRN+1344
        lda RAM_DLSA+1
        sbc >SCRN+1344
        bcs exitv
        
        lda #2
        sta VSC
        lda #$42
        sta VSF
SCRL:  
        bit VSF
        bpl SCRLDW
        
        lda VSC
        bne SCRLUP1
        sta VSCROL
        
        lda #$0e
        sta VSC
        
        lda VSF
        dec VSF
        and #$0f
        bne exitv2
        sta VSF
exitv2: rts
SCRLUP1:
        dec VSC
        dec VSC
        AND #7
        sta VSCROL
        cmp #6
        bne exitv2
        
        sec
        lda RAM_DLSA
        sbc #$20
        sta RAM_DLSA
        bcs scrup1
        dec RAM_DLSA+1
scrup1: 
        lda #6
        sta VSCROL
        lda VSC
        bne exitv2       

SCRLDW: lda VSC
        inc VSC
        inc VSC
        and #7
        sta VSCROL
        bne exitv3
ldw:    clc
        lda RAM_DLSA
        adc #$20
        sta RAM_DLSA
        bcc ldw1
        inc RAM_DLSA+1
ldw1:   
        lda VSC
        cmp #$10
        bcc exitv3
        
        lda VSF
        dec VSF
        and #$0f
        bne ldw2
        sta VSF
ldw2: 
        lda #2
        sta VSC
exitv3:
        rts
        
DISPLAY_BYTE:
        pha
        jsr DSPD
        pla
        lsr
        lsr
        lsr
        lsr
DSPD:   and #$0f
        clc
        adc #$0b
        sta RAM_INFO,y
        sbc #$09
        sta RAM_INFO+40,y
        dey
        rts

wait_trig:
        pha
wtloop:
        lda TRIG0
        bne wtloop
        pla
        rts
        

.ENDL