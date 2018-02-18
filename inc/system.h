SYSTEM    .LOCAL

DETECT_ENV:
;************** Detect envorinment ****************  

        lda     GTIAPAL          ;Read PAL register
        and     #$0e             ;Mask off bits 1-3
        bne     is_ntsc
        lda     #$80
is_ntsc:
        and     #$80             ; PAL GTIA - 7th bit set to 1
        sta     REGION
 
        lda     $FD32
        cmp     #$e8             ; inx ($e8) in 4 port bios
        bne     is_2port
        lda     #$40
is_2port:
        and     #$40             ; 4 port bios - 6th bit set to 1                       
        ora     REGION          
        sta     REGION

        rts

INIT_RAM:
;************* Clear RAM **************************

        ldy     #$00            ;Clear Ram
        lda     #$02            ;Start at $0200
        sta     $81             
        lda     #$00
        sta     $80
irloop:
        lda     #$00
        sta     ($80),y         ;Store data
        iny                     ;Next byte
        bne     irloop          ;Branch if not done page
        inc     $81             ;Next page
        lda     $81
        cmp     #$40            ;Check if end of RAM
        bne     irloop          ;Branch if not

        rts

ATARI_SPLASH:

        ldy     #$00
        lda     #$fd
        sta     $81
        
        lda     REGION
        and     #$40
        beq     as2port
        lda     #$42
        jmp     as_copyrom
as2port:
        lda     #$58
as_copyrom:
        sta     $80

as_loop1:        
        lda     ($80),y
        sta     $0400,y
        iny
        bne     as_loop1
        
        ldy     #$4c
        inc     $81
as_loop2:        
        lda     ($80),y
        sta     $0500,y
        dey
        bpl     as_loop2
        
        lda     #$60
        sta     $054c
        
        ldx     #$0b
        lda     #$ea
as_loop3:
        sta     $0532,x
        dex
        bpl     as_loop3
        
        jsr     $0400

        lda $BFFC
        bne continue
        rts
continue:        
        // put year into screen memory
        lda #"2"
        sta $3c9e
        
        lda $BFFC
count100:
        cmp #100
        bmi count10
        sec
        sbc #100
        inc $20
        jmp count100
count10:
        cmp #10
        bmi count1
        sec
        sbc #10
        inc $21
        jmp count10
count1:
        cmp #1
        bmi count_done
        sec
        sbc #1
        inc $22
        jmp count1
count_done:
        ldx #2
ns_year:
        lda $20,x
        clc
        adc #$10
        sta $3c9f,x
        dex
        bpl ns_year
        
as_wait:
        cpx $02
        bne as_wait
        rts
 ;-------------------------------------------------------------------------------
; * COPY_MEM (SRC_PTR - source address / DST_PTR - target address / COUNT_W lenght)
;-------------------------------------------------------------------------------
COPY_MEM:
        ldy #$00
        lda (SRC_PTR),y       ; move byte from address stored in $80-$81
        sta (DST_PTR),y       ; to address stored in $82-$83
        inc SRC_PTR           ; increase source address word value on zero page
        bne mvmem1
        inc SRC_PTR+1
mvmem1:
        inc DST_PTR           ; increase target address word value on zero page
        bne mvmem2
        inc DST_PTR+1
mvmem2:
        dec COUNT_WORD        ; decrease lenght word value on zero page
        bne COPY_MEM
        dec COUNT_WORD+1
        lda COUNT_WORD+1
        cmp #$ff
        bne COPY_MEM
        rts           
       
.ENDL