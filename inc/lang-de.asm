		        opt f+h-
            org $0000
TXT_DE  .LOCAL, TEXT_RAM     
TEXT    .byte " ", $59, $5a, $16, $1e, $1d, $1e, " Avalon  ", $59, $5a, $17, $15, $16, $1b," tDIdIDiT "
        .byte " Programm ", $3f, " Grafik", $43, " Janusz Pelc "
        .byte " A",$1a, $17, $15, $15, " Version", $43," Sebastian Kotek "
;        .byte "                                "
        .byte " ", $7b, "bersetzung", $43, "      Walter Lauer "
        .byte "    Steuerung", $43, "      Joystick    "
        .byte "    Schuss", $43, "       Feuerknopf    "
;------------------------
DEMOTXT .byte "      Dr", $3d, "cke Feuer zu verlassen", $42, $42, $42, "      "
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
INST:   .byte "           "," "+$80,"A"+$80,"n"+$80,"l"+$80,"e"+$80,"i"+$80,"t"+$80,"u"+$80,"n"+$80,"g"+$80," "+$80, $40, $40
;        .byte $ff
        .byte "  Robbo muss auf seiner schweren"
        .byte "Reise  ", $1a, $1b, " Planeten  besuchen um", $41
        .byte "aus        dem       feindlichen"
        .byte "Planetensystem", $41, "   auf   dem   er"
        .byte "gefangen wurde", $41, " zu entkommen", $42, $40, $40

        .byte "  Auf jedem Planeten wartet eine"
        .byte "kleine  Rettungskapsel", $41, "  mit der"
        .byte "er zum n", $3b, "chsten Planeten fleigen"
        .byte "kann", $42, " Leider  sind  die  meisten"
        .byte "Kapseln  besch", $3b, "digt", $42, "  Daher muss"
        .byte "Robbo  die erforderliche  Anzahl"
        .byte "an  Ersatzteilen   finden", $41, "   die"
        .byte $3d, "berall    auf   dem    Planeten" 
        .byte "verstreut sind", $42,$40, $40
        
        .byte "  Das  Planetensystem  wird  von"
        .byte "feindlischen  Kreaturen bewohnt", $41
        .byte "die  Robbo  bei  seiner  Aufgabe"
        .byte "st", $3c, "ren", $42,"  Robbo findet auf seiner"
        .byte "Suche diverse Gegenst", $3b, "nde", $42," Finde"
        .byte "heraus", $41," wof", $3d, "r diese zu gebrauche"
        .byte "sind", $42,"  Versuche  die Gegenst", $3b, "nde"
        .byte "durch   Dr", $3d, "cken", $41,"  Sammeln   oder"
        .byte "Schiessen zu benutzen", $42, $40, $40

        .byte "Wenn Robbo hoffnungslos verloren"
        .byte "ist und festh", $3b, "ngt", $41, $40 
        .byte "                 dr", $3d, "cke ", " "+$80, "R"+$80, "E"+$80, "S"+$80, "E"+$80, "T"+$80, " "+$80, $42, $40

        .byte "  Jeder  Planet  kann  geschafft"
        .byte "werden", $44, $40, $40

        .byte "Die Authoren w", $3d, "nschen viel Spass"
        .byte "beim Spielen", $42, $40, $40

        .byte "  Wenn er dir gelingt  das ganze"
        .byte "Planetensystem zu beraisen", $41," dann"
        .byte "schreib uns  und  beschreibe das"
        .byte "Ende  des  Spiel", $42, "  Die  ersten ", $1a
        .byte "werden   mit  einer   besonderen"
        .byte "Kopie  unseres  n", $3b, "chsten  Spiele"
        .byte "belohnt", $42, $40
;        .byte "                                "

        .byte $40, $40, $40, $40, $40
        .byte $40, $40, $ff
.ENDL
