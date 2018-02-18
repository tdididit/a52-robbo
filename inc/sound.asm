SOUND     .LOCAL
SOUND_: tax
        bmi psst
        
        lda #0
        sta _SCRA+1
        txa
        asl
        asl
        asl
        rol _SCRA+1
        asl
        rol _SCRA+1
        asl
        rol _SCRA+1
        adc <TABS
        sta _SCRA
        lda _SCRA+1
        adc >TABS
        sta _SCRA+1
        
        cpx #3
        bcc *+4
        ldx #3
        
        lda #$10
        sta _PNTR,x
        
        txa
        asl
        tax
        lda _SCRA
        sta _ADDR,x
        lda _SCRA+1
        sta _ADDR+1,x
        rts

psst:   lda #3
        sta SKCTL
        
        lda #0
        ldx #8
rese:   sta _PNTR,x
        sta VOIC,x
        dex
        bpl rese
        rts
        
;* Play -------------

SOUNDV: lda RTCLOKL ; 20
        and #3
        beq *+3
        rts
        
        ldx #3
        ldy #6
so1:    lda _PNTR,x
        beq so2
        jsr SOPL
        jmp so3
        
so2:    sta VOIC,y
        sta VOIC+1,y
        
so3:    dey
        dey
        dex
        bpl so1
        rts
;* ------------------

SOPL:   tya
        pha
        
        lda _ADDR,y
        sta _SCRA
        lda _ADDR+1,y
        sta _SCRA+1
        
        ldy _PNTR,x
        dey
        sty _PNTR,x
        tya
        asl
        tay
        lda (_SCRA),y
        sta _HLP
        iny
        lda (_SCRA),y
        sta _HLP+1
        
        pla
        tay
        lda _HLP+1
        sta VOIC,y
        lda _HLP
        sta VOIC+1,y
        rts
                
;* ------------------

TABS EQU *

;* wybuch -----------   0

        .word $0000
        .word $0000
        .word $0000
        .word $0000
        .word $2281
        .word $2281
        .word $2282
        .word $2283
        .word $2283
        .word $2284
        .word $2285
        .word $2285
        .word $2286
        .word $2287
        .word $2288
        .word $2286

;* strzal -----------   1

        .word $0000
        .word $0000
        .word $0000
        .word $0000
        .word $0000
        .word $0000
        .word $0000
        .word $0000
        .word $0000
        .word $0000
        .word $0000
        .word $0000
        .word $0000
        .word $0381
        .word $0282
        .word $0183

;* stuk -------------   2

        .word $0000
        .word $0000
        .word $0000
        .word $0000
        .word $0000
        .word $0000
        .word $0000
        .word $0000
        .word $0000
        .word $0000
        .word $0000
        .word $0000
        .word $0000
        .word $0000
        .word $0000
        .word $0181

;* teleport ---------   3

        .word $0000
        .word $60A1
        .word $40A1
        .word $20A1
        .word $61A2
        .word $42A2
        .word $23A2
        .word $64A2
        .word $45A3
        .word $26A3
        .word $67A3
        .word $48A3
        .word $29A4
        .word $6AA4
        .word $4BA4
        .word $2CA4

;* srubka -----------   4

        .word $0000
        .word $0000
        .word $0000
        .word $0000
        .word $0000
        .word $0000
        .word $0000
        .word $0000
        .word $0000
        .word $0000
        .word $0000
        .word $0000
        .word $2BA1
        .word $2AA2
        .word $2BA3
        .word $2AA4

;* extra life -------   5

        .word $45A1
        .word $44A2
        .word $45A3
        .word $44A6
        .word $51A3
        .word $50A6
        .word $45A1
        .word $44A2
        .word $45A3
        .word $44A6
        .word $8AA3
        .word $88A6
        .word $8AA3
        .word $88A6
        .word $8AA3
        .word $88A6

;* drzwi ------------   6

        .word $0000
        .word $0000
        .word $0000
        .word $0000
        .word $0000
        .word $8801
        .word $94C1
        .word $A903
        .word $92C4
        .word $B0C5
        .word $ADC6
        .word $BEC7
        .word $CEC8
        .word $D4C8
        .word $E8C7
        .word $F808

;* naboje -----------   7

        .word $0000
        .word $01C1
        .word $0000
        .word $01C1
        .word $0000
        .word $01C2
        .word $0000
        .word $01C3
        .word $0000
        .word $01C4
        .word $0000
        .word $01C3
        .word $0000
        .word $01C2
        .word $0000
        .word $01C1

;* skrzynia ---------   8

        .word $0000
        .word $0000
        .word $0000
        .word $0000
        .word $0000
        .word $0000
        .word $0000
        .word $0000
        .word $0000
        .word $0000
        .word $0000
        .word $0000
        .word $0000
        .word $8201
        .word $8002
        .word $8101

;* klucz ------------   9
                   
        .word $0000
        .word $0000
        .word $0000
        .word $0000
        .word $0000
        .word $0000
        .word $0000
        .word $0000
        .word $0000
        .word $0000
        .word $11A1
        .word $12A2
        .word $13A3
        .word $14A4
        .word $15A5
        .word $16A6

;* wybuszek ---------   a

        .word $0000
        .word $0000
        .word $0000
        .word $0000
        .word $0000
        .word $0000
        .word $0000
        .word $0000
        .word $0000
        .word $0581
        .word $0582
        .word $0583
        .word $0584
        .word $0684
        .word $0683
        .word $0682

;* wejscie              b
                   
        .word $0AA1
        .word $0AA2
        .word $0AA4
        .word $0AA6
        .word $0AA8
        .word $0000
        .word $0000
        .word $0000
        .word $0000
        .word $0887
        .word $1086
        .word $2085
        .word $3084
        .word $4083
        .word $5082
        .word $6081

;*                      c

        .word $0000
        .word $10A1
        .word $10A1
        .word $10A2
        .word $10A3
        .word $10A4
        .word $10A1
        .word $10A2
        .word $10A3
        .word $10A4
        .word $10A5
        .word $10A2
        .word $10A3
        .word $10A5
        .word $10A7
        .word $10A8

;* otwarcie wyjscia     d

        .word $1801
        .word $0801
        .word $1802
        .word $0802
        .word $1803
        .word $0803
        .word $1804
        .word $0804
        .word $1805
        .word $0805
        .word $1806
        .word $0806
        .word $1808
        .word $0808
        .word $180A
        .word $080A

;* przyciaganie         e

        .word $1008
        .word $0008
        .word $0007
        .word $0007
        .word $1006
        .word $0006
        .word $0005
        .word $0005
        .word $1004
        .word $0004
        .word $0003
        .word $0003
        .word $1002
        .word $0002
        .word $0001
        .word $0001

;********************
.ENDL