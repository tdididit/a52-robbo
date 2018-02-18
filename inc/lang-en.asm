		        opt f+h-
            org $0000
TXT_EN  .LOCAL, TEXT_RAM     
TEXT    .byte " ", $59, $5a, $16, $1e, $1d, $1e, " Avalon  ", $59, $5a, $17, $15, $16, $1b," tDIdIDiT "
        .byte " Code and graphics", $43, " Janusz Pelc "
        .byte " A",$1a, $17, $15, $15, " version", $43," Sebastian Kotek "
        .byte "                                "
;        .byte " T", $3d, "umaczenie", $43, "        Jozsef Vas "
        .byte "    Control", $43, "        joystick    "
        .byte "    Shot", $43, "        fire button    "
;------------------------
DEMOTXT .byte "  Press FIRE button to quit demo mode", $42, "  "
;------------------------         
COTX    .byte $60, $60, $60, $60, $60, $60, $60, $60
        .byte $60, $60, $60, $60, $60, $60, $60, $60
        .byte $60, $60, $60, $60, $60, $60, $60, $60
        .byte $60, $60, $60, $60, $60, $60, $60, $60
        
        .byte $60, "                              ", $60
        .byte $60, "        CONGRAULATIONS", $44, "       ", $60
        .byte $60, "                              ", $60
        .byte $60, "  Robbo escaped from hostile  ", $60
        .byte $60, " planetary system", $42, "            ", $60
        .byte $60, "  The plans in his memory are ", $60
        .byte $60, " very valuable for Earth", $44, "     ", $60
        .byte $60, "                              ", $60
        .byte $60, "  Thus you finished our first ", $60
        .byte $60, " game", $42, " If you liked it", $41, " try   ", $60
        .byte $60, " to find next", $42, "                ", $60
        .byte $60, "                              ", $60
        .byte $60, " Take a part in Robbo contest ", $60
        .byte $60, "                              ", $60
        .byte $60, "     Send secret password     ", $60
        .byte $60, "         ABCDEFGHIJKL         ", $60
        .byte $60, "    to", $43, " robbo", $5b, "tdididit", $42, "com    ", $60
        .byte $60, "                              ", $60

        .byte $60, $60, $60, $60, $60, $60, $60, $60
        .byte $60, $60, $60, $60, $60, $60, $60, $60
        .byte $60, $60, $60, $60, $60, $60, $60, $60
        .byte $60, $60, $60, $60, $60, $60, $60, $60
;------------------------
INST:   .byte "          "," "+$80,"I"+$80,"n"+$80,"s"+$80,"t"+$80,"r"+$80,"u"+$80,"c"+$80,"t"+$80,"i"+$80,"o"+$80,"n"+$80," "+$80, $40, $40
;        .byte $ff
        .byte "    Robbo  need  to  travel  his"
        .byte "journey thru  ", $1a, $1b, " planets  to get"
        .byte "out  from  the hostile planetary"
        .byte "system  where he was insidiously"
        .byte "trapped", $42, $40

        .byte "On each  planet  waiting for him"
        .byte "a  small capsule", $41, " he  can fly to"
        .byte "the next planet with it", $42, $40
        .byte "Unfortunately", $41, "   most   of   the"
        .byte "capsules is incomplete", $41, " so Robbo"
        .byte "must  collect  the   appropriate"
        .byte "amount   of  replacement   parts"
        .byte "scattered across the planet", $42,$40
        .byte "Will disturb him  evil creatures"
        .byte "    ", $1f, " inhabitants of the system", $42
        .byte "In his  journey  Robbo will find"
        .byte "various  items", $42, "  Discover  their"
        .byte "destiny", $42, "  Try   to  push   them", $41
        .byte "collect or shoot them", $42, $40, $40

        .byte "If Robbo  will be in  a hopeless"
        .byte "situation", $41, " press ", " "+$80, "R"+$80, "E"+$80, "S"+$80, "E"+$80, "T"+$80, " "+$80, $42, $40, $40

        .byte "Remember", $41, "  you  can  pass  every"
        .byte "planet", $44, $40, $40

        .byte "Authors wish you have fun", $42, $40, $40

        .byte "If  you manage to go through the"
        .byte "whole planetary system", $41, " write to"
        .byte "us and review end of game", $42, $40
        .byte "First ", $1a, " persons will be rewarded"
        .byte "with special copy of our next",$40
        .byte "game", $42, $40
;        .byte "                                "

        .byte $40, $40, $40, $40, $40
        .byte $40, $40, $ff
.ENDL
