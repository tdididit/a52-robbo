; Atari 5200 Robbo
; Written by Sebastian Kotek (tdididit@gmail.com)
;
; Assemble with MADS 2.0.0
;
  		      icl 'inc/a5200.h'
  		      icl 'inc/5200macro.h'
	
		        opt f+h-
            org $0080
;************ Zero Page Variables ****************
SRC_PTR     .ds 2
DST_PTR     .ds 2
COUNT_WORD  .ds 2

ADDR        .ds 2
SCRA        .ds 2
CHAD        .ds 2
FADR        .ds 2

_PNTR       .ds 4
_ADDR       .ds 8
_SCRA       .ds 2
_HLP        .ds 2
        
;* system
JOY         = POT0
TRIG        = TRIG0
TMR         = RTCLOCK

RND         = RANDOM
VSCR        = VSCROL

VOIC        = AUDF1

COLB        = PCOLR3

;* program
CAVE      = $0400
CAPA = CAVE + $01f0                        

IFNT_RAM      = $0800
FONT_RAM      = $0c00

SCRN          = $1000

TEXT_RAM      = $3000
DTXT_RAM      = TEXT_RAM + $00c0
COTX_RAM      = TEXT_RAM + $00e8
INST_RAM      = TEXT_RAM + $0368

INFLATE_RAM   = $3a00

            org $0280
X_POS       .ds 1
Y_POS       .ds 1
X1          .ds 1
Y1          .ds 1
FX          .ds 1
FY          .ds 1
LM          .ds 1
VSF         .ds 1
VSC         .ds 1
TELE        .ds 1
FAC         .ds 1
CNUM        .ds 1

KEYS        .ds 1
LIVS        .ds 1
ZEBR        .ds 1
LSTE  equ *
SKRB        .ds 1
NABO        .ds 1
DEMO        .ds 1

SCOR        .ds 3

HLP         .ds 1
RUCH        .ds 1
LAST        .ds 1
TOLE  equ *
PNTR        .ds 1
DCV         .ds 1

STCN        .ds 1
SETUP_HLP   .ds 1
ROTM_HLP    .ds 1
DLI_HLP     .ds 1
BDEC        .ds 1
HELP_20     .ds 1
CNTR        .ds 1
NOGA_HLP    .ds 1
STRC        .ds 1

LANG_HLP    .ds 1
            
            org $02f0
RAM_MASK    .ds 6
SCHBASE     .ds 1          
            org $02FF
;****************** Variables ********************
REGION      .ds 1

            org $0300
RAM_CVDL  equ *

            org $4000
ROMTOP  equ *
            icl 'inc/system.h'	

;*************** Start of Code *******************
START:
        sei                     ;Disable interrupts
        cld                     ;Clear decimal mode
        
        jsr     SYSTEM.DETECT_ENV

        ldx     #$FF
        txs                     ; set stack pointer to $FF
        inx
        
        lda     #$00
crloop1    
        sta     $00,x           ;Clear zero page
        sta     DMACTL,x        ;Clear ANTIC  DMACTL   =   $D400
        sta     HPOSP0,x        ;Clear GTIA   HPOSP0   =   $C000
        sta     AUDF1,x         ;Clear POKEY  AUDF1    =   $E800
        dex
        bne     crloop1

                
        lda $BFFD   ; check did ROM splash sccren was showed
        cmp #$ff
        bne MAIN
        jsr SYSTEM.ATARI_SPLASH

;****** Main Routine after Startup Procedure ******

MAIN:   

        lda #$00        ;disable NMI & IRQ
        sta LANG_HLP
        sta NMIEN
        sta SDMCTL
        
        lda <modIMIRQ
        sta VVBLKI
        lda >modIMIRQ
        sta VVBLKI+1
        
        lda #$c0        ;enable interrupts
        sta NMIEN
        
        
;- copy ROM to RAM
;- inflate 
        lda #$00
        sta SRC_PTR
        sta DST_PTR
        lda #$bc
        sta SRC_PTR+1
        lda #$3a
        sta DST_PTR+1
        lda <inflate_size
        sta COUNT_WORD
        lda >inflate_size
        sta COUNT_WORD+1
        jsr SYSTEM.COPY_MEM 
;- ifnt              
;        lda <IFNT
;        sta SRC_PTR
;        lda >IFNT
;        sta SRC_PTR+1
;        lda <IFNT_RAM
;        sta DST_PTR
;        lda >IFNT_RAM
;        sta DST_PTR+1
;        lda #$00
;        sta COUNT_WORD
;        lda #$04
;        sta COUNT_WORD+1
;        jsr SYSTEM.COPY_MEM 
;- font
        lda <FONT
        sta SRC_PTR
        lda >FONT
        sta SRC_PTR+1
        lda <FONT_RAM
        sta DST_PTR
        lda >FONT_RAM
        sta DST_PTR+1
        lda #$00
        sta COUNT_WORD
        lda #$04
        sta COUNT_WORD+1
        jsr SYSTEM.COPY_MEM 

;* move CVDL to RAM
        ldx GAME.CVDL_SIZE
mvCVDL: lda GAME.CVDL,x
        sta RAM_CVDL,x
        dex
        bne mvCVDL
        
        lda #0
        sta LANG_HLP

;* unpack ifont to RAM
        jsr UNPACK_IFNT
        
        jsr LANGUAGE.CHOOSE
        
        lda #0
        sta HLP
;        sta SETUP_HLP
        sta SDMCTL
        
        ldx #16
        jsr TITLE.WAIT        
        
;* unpack ifont to RAM
        jsr UNPACK_IFNT
                
;* unpack language to RAM
        jsr UNPACK_LANG
        
        lda #0
        sta SETUP_HLP
        sta RTCLOKL
        sta RTCLOKH
        
        inc RTCLOKL
        
                
        jmp TITLE.TITLE

UNPACK_IFNT:        
        lda LANG_HLP
        asl
;- unpack IFNT to RAM
        tax
        lda IFNT_PTRS,x
        sta inflate_rom.inputPointer
        lda IFNT_PTRS+1,x
        sta inflate_rom.inputPointer+1
        
        lda <IFNT_RAM
        sta inflate_rom.outputPointer
        lda >IFNT_RAM
        sta inflate_rom.outputPointer+1
        
        jsr inflate_rom.inflate
        rts
        
UNPACK_LANG:        
        lda LANG_HLP
        asl
;- unpack LANG to RAM
        tax
        lda LANG_PTRS,x
        sta inflate_rom.inputPointer
        lda LANG_PTRS+1,x
        sta inflate_rom.inputPointer+1
        
        lda <TEXT_RAM
        sta inflate_rom.outputPointer
        lda >TEXT_RAM
        sta inflate_rom.outputPointer+1
        
        jsr inflate_rom.inflate
        
        ldx #40
ul_loop:
        lda DTXT_RAM,x
        sta GAME.RAM_DINF,x
        dex
        bpl ul_loop
        rts
        
        icl 'inc/title.asm'
        icl 'inc/game.asm'
        icl 'inc/sound.asm'
        icl 'inc/languages.asm'

;        org     $8600
       align 256
MFNT:
       icl 'inc/mfnt.asm'
;        ins 'raw/m.fnt', +6
SFNT:
       icl 'inc/sfnt.asm'
;        ins 'raw/s.fnt', +6
FONT:
;       icl 'inc/font.asm'
        ins 'raw/f.fnt', +6
;IFNT:
;        ins 'raw/robbo5200.fnt'
;        ins 'raw/i.fnt', +6
;INFORFNT:
;        ins 'raw/infor.fnt', +6
ifnt_pl:
        ins 'raw/ifnt.def'
ifnt_hu:
        ins 'raw/ifnt-hu.def'
ifnt_de:
        ins 'raw/ifnt-de.def'

IFNT_PTRS:
        .word ifnt_pl
        .word ifnt_hu
        .word ifnt_pl
        .word ifnt_de
        
lang_pl:
        ins 'raw/lang-pl.def'
lang_hu:
        ins 'raw/lang-hu.def'
lang_en:
        ins 'raw/lang-en.def'
lang_de:
        ins 'raw/lang-de.def'

LANG_PTRS:
        .word lang_pl
        .word lang_hu
        .word lang_en
        .word lang_de        
cave001:
        ins 'caves/def-caves/cave-001.def'
cave002:
        ins 'caves/def-caves/cave-002.def'
cave003:
        ins 'caves/def-caves/cave-003.def'
cave004:
        ins 'caves/def-caves/cave-004.def'
cave005:
        ins 'caves/def-caves/cave-005.def'
cave006:
        ins 'caves/def-caves/cave-006.def'
cave007:
        ins 'caves/def-caves/cave-007.def'
cave008:
        ins 'caves/def-caves/cave-008.def'
cave009:
        ins 'caves/def-caves/cave-009.def'
cave010:
        ins 'caves/def-caves/cave-010.def'
cave011:
        ins 'caves/def-caves/cave-011.def'
cave012:
        ins 'caves/def-caves/cave-012.def'
cave013:
        ins 'caves/def-caves/cave-013.def'
cave014:
        ins 'caves/def-caves/cave-014.def'
cave015:
        ins 'caves/def-caves/cave-015.def'
cave016:
        ins 'caves/def-caves/cave-016.def'
cave017:
        ins 'caves/def-caves/cave-017.def'
cave018:
        ins 'caves/def-caves/cave-018.def'
cave019:
        ins 'caves/def-caves/cave-019.def'
cave020:
        ins 'caves/def-caves/cave-020.def'
cave021:
        ins 'caves/def-caves/cave-021.def'
cave022:
        ins 'caves/def-caves/cave-022.def'
cave023:
        ins 'caves/def-caves/cave-023.def'
cave024:
        ins 'caves/def-caves/cave-024.def'
cave025:
        ins 'caves/def-caves/cave-025.def'
cave026:
        ins 'caves/def-caves/cave-026.def'
cave027:
        ins 'caves/def-caves/cave-027.def'
cave028:
        ins 'caves/def-caves/cave-028.def'
cave029:
        ins 'caves/def-caves/cave-029.def'
cave030:
        ins 'caves/def-caves/cave-030.def'
cave031:
        ins 'caves/def-caves/cave-031.def'
cave032:
        ins 'caves/def-caves/cave-032.def'
cave033:
        ins 'caves/def-caves/cave-033.def'
cave034:
        ins 'caves/def-caves/cave-034.def'
cave035:
        ins 'caves/def-caves/cave-035.def'
cave036:
        ins 'caves/def-caves/cave-036.def'
cave037:
        ins 'caves/def-caves/cave-037.def'
cave038:
        ins 'caves/def-caves/cave-038.def'
cave039:
        ins 'caves/def-caves/cave-039.def'
cave040:
        ins 'caves/def-caves/cave-040.def'
cave041:
        ins 'caves/def-caves/cave-041.def'
cave042:
        ins 'caves/def-caves/cave-042.def'
cave043:
        ins 'caves/def-caves/cave-043.def'
cave044:
        ins 'caves/def-caves/cave-044.def'
cave045:
        ins 'caves/def-caves/cave-045.def'
cave046:
        ins 'caves/def-caves/cave-046.def'
cave047:
        ins 'caves/def-caves/cave-047.def'
cave048:
        ins 'caves/def-caves/cave-048.def'
cave049:
        ins 'caves/def-caves/cave-049.def'
cave050:
        ins 'caves/def-caves/cave-050.def'
cave051:
        ins 'caves/def-caves/cave-051.def'
cave052:
        ins 'caves/def-caves/cave-052.def'
cave053:
        ins 'caves/def-caves/cave-053.def'
cave054:
        ins 'caves/def-caves/cave-054.def'
cave055:
        ins 'caves/def-caves/cave-055.def'
cave056:
        ins 'caves/def-caves/cave-056.def'
        
CAVESPTRS:
        .word cave001, cave002, cave003, cave004, cave005, cave006, cave007, cave008
        .word cave009, cave010, cave011, cave012, cave013, cave014, cave015, cave016
        .word cave017, cave018, cave019, cave020, cave021, cave022, cave023, cave024
        .word cave025, cave026, cave027, cave028, cave029, cave030, cave031, cave032
        .word cave033, cave034, cave035, cave036, cave037, cave038, cave039, cave040
        .word cave041, cave042, cave043, cave044, cave045, cave046, cave047, cave048
        .word cave049, cave050, cave051, cave052, cave053, cave054, cave055, cave056                           

        org $bc00
inflate_rom .LOCAL, $3a00
;inflate	= $3b00
inflate_zp	= $f0
inflate_data	= $3d00

        icl 'inc/inflate.asm'
CALL:   jsr $0000
        jmp GAME.CHCC
JMP1:   jmp $0000
SJMP:   jmp $0000
.ENDL
inflate_size = *-$bc00

;* moddified IMMEDIATE VBI
JOY0    = $19

RTCLOCK   = $20
CDTMR1  = $0220
CDTMR2  = $0222
CDTMR3  = $0224
CDTMR4  = $0228
CDTMR5  = $022a
CDTMR6  = $022c
CDTMR7  = $022e

modIMIRQ:
        pha
        txa
        pha
        tya
        pha
        
        inc RTCLOKL
        bne nxtclk
        inc ATRACT
        inc RTCLOKH
nxtclk:
cdtimersproc:        
        lda CDTMR1
        ora CDTMR1+1
        beq clkend1
        lda CDTMR1
        eor #$ff
        tay
        lda CDTMR1+1
        eor #$ff
        tax
        inx
        bne nohigh1
        iny
nohigh1:
        txa
        eor #$ff
        sta CDTMR1+1
        tya
        eor #$ff
        sta CDTMR1
clkend1:

        lda CDTMR2
        ora CDTMR2+1
        beq clkend2
        lda CDTMR2
        eor #$ff
        tay
        lda CDTMR2+1
        eor #$ff
        tax
        inx
        bne nohigh2
        iny
nohigh2:
        txa
        eor #$ff
        sta CDTMR2+1
        tya
        eor #$ff
        sta CDTMR2
clkend2:
mi_fcc5:        
        lda CODFLG
        beq mi_fcc9 
        jmp $fcb2 ; BIOS exit from NMI
mi_fcc9:
        lda SDLSTH
        sta DLISTH
        lda SDLSTL
        sta DLISTL
        lda SDMCTL
        sta DMACTL
        lda SCHBASE
        sta CHBASE
        ldy ATRACT
        bpl mi_fce0
        ldy #$80
        sty ATRACT
mi_fce0:        
        ldx #$08
mi_fce2:        
        lda PCOLR0,x
        cpy #$80
        bcc mi_fcec
        eor RTCLOKH
        and #$f6
mi_fcec:
        sta COLPM0,x
        dex
        bpl mi_fce2
        
        ldx #$07
mi_fcf4:        
        lda PPOT0,x
        sta POT0,x
        dex
        bpl mi_fcf4
        sta POTGO
        
;        lda TITLE_HLP
;        beq cdtimersproc
        
        jsr POT2JOY
        jsr GAME.CVBL

        lda #0
        sta DLI_HLP
               
        jmp (VVBLKD)
        
POT2JOY:
;        lda RTCLOKL
;        and #$3
;        beq p2jgo
;        rts
p2jgo:  clc
        lda #$0f
        ldx POT0   ; $00 left / $e4 right
        cpx #$39
        bcs nolft
        and #$0b
        jmp norght
nolft:  
        cpx #171 ;#144
        bcc norght
        and #$07
        
norght: clc
        ldx POT1   ; $00 up   / $e4 down
        cpx #$39; #$72
        bcs noup
        and #$0e
        jmp nodwn
noup:   
        cpx #171 ;#144
        bcc nodwn
        and #$0d
nodwn:  sta JOY0
        rts                
        
;************** Cart reset vector **************************

        org     $bfe7
.array signature [23] .byte = $00
[0] = $00                 ; $15 - PAL compatible / $00 - NTSC only
[1] = "     ROBBO 5200"   ; Title
[21] = $10, $ff 	          ; $00FF = Don't display Atari logo
                          ; $xxFF = Show new splash with 2000+$xx year   
.enda
        .word   START     ; Start code vector 
