		        opt f+h-
            org $0000
TXT_PL  .LOCAL, TEXT_RAM
TEXT    .byte " ", $59, $5a, $16, $1e, $1d, $1e, " Avalon  ", $59, $5a, $17, $15, $16, $1b," tDIdIDiT "
        .byte " Program i grafika", $43, " Janusz Pelc "
        .byte " Wersja A",$1a, $17, $15, $15, $43, "  Sebastian Kotek "
        .byte "                                "
;        .byte " T", $3d, "umaczenie", $43, "        Jozsef Vas "
        .byte "    Sterowanie", $43, "     joystick    "
        .byte "    Strza", $3D, $43, "         przycisk    "
;------------------------
DEMOTXT .byte "Wci", $7b, "ni", $3c, "cie strza", $3d, "u przerywa demonstracj", $3c
;------------------------         
COTX    .byte $60, $60, $60, $60, $60, $60, $60, $60
        .byte $60, $60, $60, $60, $60, $60, $60, $60
        .byte $60, $60, $60, $60, $60, $60, $60, $60
        .byte $60, $60, $60, $60, $60, $60, $60, $60
        
        .byte $60, "                              ", $60
        .byte $60, "          B R A W O ", $44, "         ", $60
        .byte $60, "                              ", $60
        .byte $60, "   Robbo przedosta", $3d, " si", $3c, " przez ", $60
        .byte $60, " wrogi system planetarny", $42, "     ", $60
        .byte $60, "   Plany", $41, " kt", $3f, "re ma w pami", $3c, "ci", $41, " ", $60
        .byte $60, " s", $20, " bardzo cenne dla Ziemi", $44, "   ", $60
        .byte $60, "                              ", $60
        .byte $60, "   Tym samym uko", $3e, "czy", $3d, "e", $7b, " nasz", $20, " ", $60
        .byte $60, " pierwsz", $20, " gr", $3c , $42, "  Je", $7c, "eli Ci si", $3c, " ", $60
        .byte $60, " podoba", $3d, "a", $41, " szukaj nast", $3c, "pnych", $42, " ", $60
        .byte $60, "                              ", $60
        .byte $60, " We", $7c, " udzia", $3d, " w konkursie Robbo ", $60
        .byte $60, "                              ", $60
        .byte $60, "      Wy", $7b, "lij tajne has", $3d, "o      ", $60
        .byte $60, "         ABCDEFGHIJKL         ", $60
        .byte $60, " na adres", $43, " robbo", $5b, "tdididit", $42, "com ", $60
        .byte $60, "                              ", $60

        .byte $60, $60, $60, $60, $60, $60, $60, $60
        .byte $60, $60, $60, $60, $60, $60, $60, $60
        .byte $60, $60, $60, $60, $60, $60, $60, $60
        .byte $60, $60, $60, $60, $60, $60, $60, $60
;------------------------
INST:   .byte "          "," "+$80,"I"+$80,"n"+$80,"s"+$80,"t"+$80,"r"+$80,"u"+$80,"k"+$80,"c"+$80,"j"+$80,"a"+$80," "+$80, $40, $40
;        .byte $ff
        .byte "    Robbo  musi  przeby", $3b, "  trudn", $20
        .byte "drog", $3c, "   przez  ", $1a, $1b, "   planet", $41, "  aby"
        .byte "wydosta", $3b," si", $3c,"  z wrogiego  uk", $3d, "adu"
        .byte "planetarnego", $41, "  na kt", $3f, "rym  zosta", $3d
        .byte "podst", $3c, "pnie uwi", $3c, "ziony", $42, $40, $40
        
        .byte "    Na ka", $7c, "dej  planecie czeka na"
        .byte "niego  ma", $3d, "a kapsu", $3d, "a", $41, " kt", $3f, "r", $20, "  mo", $7c, "e"
        .byte "przelecie", $3b, " na nast", $3c, "pn", $20, "  planet", $3c, $42
        .byte "Niestety", $41, "  wi", $3c, "kszo", $7b, $3b, " kapsu", $3d, " jest"
        .byte "niekompletna", $41, " dlatego Robbo musi"
        .byte "zebra", $3b, " odpowiedni", $20, " liczb", $3c, " cz", $3c, $7b, "ci"
        .byte "rozrzuconych  po ca", $3d, "ej planecie", $42
        .byte "B", $3c, "d", $20, "  mu w tym przeszkadza", $3b, "  z", $3d, "e"
        .byte "stworki  ", $1f, "  mieszka", $3e, "cy  systemu", $42
        .byte "W swojej w", $3c, "dr", $3f, "wce Robbo znajdzie"
        .byte "r", $3f, $7c, "ne   przedmioty", $42,"  Odkryj  ich"
        .byte "przeznaczenie", $42, "  Pr", $3f, "buj je pcha", $3b, $41
        .byte "zbiera", $3b, " lub strzela", $3b, " do nich", $42, $40 , $40
        
        .byte "  Je", $7c, "eli  Robbo  znajdzie  si", $3c, " w"
        .byte "sytuacji  bez  wyj", $7b, "cia", $41,"  wci", $7b, "nij"
        .byte "klawisz "," "+$80,"R"+$80,"E"+$80,"S"+$80,"E"+$80,"T"+$80," "+$80, $42, $40, $40

        .byte "  Pami", $3c, "taj", $41, "  ", $7c, "e   ka", $7c, "d", $20, "   plant", $3c
        .byte "mo", $7c, "na przej", $7b, $3b, $44, $40, $40 ;, $40
        .byte "  Mi", $3d, "ej zabawy ", $7c, "ycz", $20, " Ci autorzy", $42, $40;, $40, $40
        
        .byte "  Je", $7c, "eli uda Ci si", $3c, " przeby", $3b, " ca", $3d, "y"
        .byte "system planetarny", $41, " napisz do nas"
        .byte "i  opisz  zako", $3e, "czenie  gry", $42, "  Dla"
        .byte "pierwszych pi", $3c, "ciu os", $3f, "b", $41, " kt", $3f, "re do"
        .byte "nas  napisz", $20, $41, "   nagrod", $20, "   b", $3c, "dzie"
        .byte "specjalny   egzemplarz    naszej"
        .byte "nast", $3c, "pnej gry",$42,$40,$40, $40
        
;        .byte " Port gry dla Atari ",$1a, $17, $15, $15," powsta", $3d
;        .byte "przy pomocy", $43, $40
;        .byte $1f, " kompilatora MADS ",$17,$42,$15,$42,$15, $40
;        .byte $1f, " emulatora MESS ", $15, $42, $16, $1a, $1c, $40
;        .byte "           ", $42, $42, $42," w maju ", $17, $15, $16, $1b, " roku", $42, $40
;        .byte "                                ", $40
        .byte $40, $40, $40
        .byte $40, $40, $ff
     

.ENDL