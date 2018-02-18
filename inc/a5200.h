; OS EQUATES
; ----------
; DISPLAY LIST EQUATES
;
ADLI     =   $80
AVB      =   $40
ALMS     =   $40
AVSCR    =   $20
AHSCR    =   $10
AJMP     =   $01
AEMPTY1  =   $00
AEMPTY2  =   $10
AEMPTY3  =   $20
AEMPTY4  =   $30
AEMPTY5  =   $40
AEMPTY6  =   $50
AEMPTY7  =   $60
AEMPTY8  =   $70
;
; OS VARIABLES FOR 5200
;
; PAGE 0
;
POKMSK   =   $00
RTCLOKH  =   $01
RTCLOKL  =   $02
CODFLG   =   $03
ATRACT   =   $04
SDLSTL   =   $05
SDLSTH   =   $06
SDMCTL   =   $07
PCOLR0   =   $08
PCOLR1   =   $09
PCOLR2   =   $0A
PCOLR3   =   $0B
COLOR0   =   $0C
COLOR1   =   $0D
COLOR2   =   $0E
COLOR3   =   $0F
COLOR4   =   $10
POT0     =   $11
POT1     =   $12
POT2     =   $13
POT3     =   $14
POT4     =   $15
POT5     =   $16
POT6     =   $17
POT7     =   $18
;
; PAGE 2
;
VIMIRQ   =   $0200 ; Immediate IRQ vector
VVBLKI   =   $0202 ; Immediate VBI vector
VVBLKD   =   $0204 ; Deffered VBI vector
VDLI     =   $0206 ; DLI vector
VKEYBD   =   $0208 ; Keyboard IRQ vector
VKEYPAD  =   $020A ; Keypad routine continuation
VBREAK   =   $020C ; BREAK key IRQ vector
VBRK     =   $020E ; BRK instruction IRQ vector
VSERIN   =   $0210 ; Serial Input Data Ready IRQ vector
VSEROR   =   $0212 ; Serial Output Data Needed IRQ vector
VSEROC   =   $0214 ; Serial Output Finished IRQ vector
VTIMR1   =   $0216 ; POKEY Timer 1 IRQ vector
VTIMR2   =   $0218 ; POKEY Timer 2 IRQ vector
VTIMR4   =   $021A ; POKEY Timer 4 IRQ vector
;
; PAL COMPATIBILITY
;
PALCOMP  =   $BFE7
;
; HARDWARE REGISTERS
;
; GTIA
;
HPOSP0   =   $C000
M0PF     =   $C000
HPOSP1   =   $C001
M1PF     =   $C001
HPOSP2   =   $C002
M2PF     =   $C002
HPOSP3   =   $C003
M3PF     =   $C003
HPOSM0   =   $C004
P0PF     =   $C004
HPOSM1   =   $C005
P1PF     =   $C005
HPOSM2   =   $C006
P2PF     =   $C006
HPOSM3   =   $C007
P3PF     =   $C007
SIZEP0   =   $C008
M0PL     =   $C008
SIZEP1   =   $C009
M1PL     =   $C009
SIZEP2   =   $C00A
M2PL     =   $C00A
SIZEP3   =   $C00B
M3PL     =   $C00B
SIZEM    =   $C00C
P0PL     =   $C00C
GRAFP0   =   $C00D
P1PL     =   $C00D
GRAFP1   =   $C00E
P2PL     =   $C00E
GRAFP2   =   $C00F
P3PL     =   $C00F
GRAFP3   =   $C010
TRIG0    =   $C010
GRAFM    =   $C011
TRIG1    =   $C011
COLPM0   =   $C012
TRIG2    =   $C012
COLPM1   =   $C013
TRIG3    =   $C013
COLPM2   =   $C014
GTIAPAL  =   $C014
COLPM3   =   $C015
COLPF0   =   $C016
COLPF1   =   $C017
COLPF2   =   $C018
COLPF3   =   $C019
COLBK    =   $C01A
PRIOR    =   $C01B
VDELAY   =   $C01C
GRACTL   =   $C01D
HITCLR   =   $C01E
CONSPK   =   $C01F
CONSOL   =   $C01F
;
; PIA
;
PORTA    =   $D300
PORTB    =   $D301
PACTL    =   $D302
PBCTL    =   $D303
;
; ANTIC
;
DMACTL   =   $D400
CHACTL   =   $D401
DLISTL   =   $D402
DLISTH   =   $D403
HSCROL   =   $D404
VSCROL   =   $D405
PMBASE   =   $D407
CHBASE   =   $D409
WSYNC    =   $D40A
VCOUNT   =   $D40B
PENH     =   $D40C
PENV     =   $D40D
NMIEN    =   $D40E
NMIRES   =   $D40F
;
; POKEY
;
AUDF1    =   $E800
PPOT0    =   $E800
AUDC1    =   $E801
PPOT1    =   $E801
AUDF2    =   $E802
PPOT2    =   $E802
AUDC2    =   $E803
PPOT3    =   $E803
AUDF3    =   $E804
PPOT4    =   $E804
AUDC3    =   $E805
PPOT5    =   $E805
AUDF4    =   $E806
PPOT6    =   $E806
AUDC4    =   $E807
PPOT7    =   $E807
AUDCTL   =   $E808
ALLPOT   =   $E808
STIMER   =   $E809
KBCODE   =   $E809
SKREST   =   $E80A
RANDOM   =   $E80A
POTGO    =   $E80B
SEROUT   =   $E80D
IRQEN    =   $E80E
IRQST    =   $E80E
SKCTL    =   $E80F
SKSTAT   =   $E80F
