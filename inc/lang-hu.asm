		        opt f+h-
            org $0000
TXT_EN  .LOCAL, TEXT_RAM     
TEXT    .byte " ", $59, $5a, $16, $1e, $1d, $1e, " Avalon  ", $59, $5a, $17, $15, $16, $1b," tDIdIDiT "
        .byte " Program ", $3b, "s grafika", $43, "Pelc Janusz "
        .byte " A",$1a, $17, $15, $15, " verzi", $3e, $43,"  Kotek Sebastian "
        .byte " Magyar ford", $3c, "t", $20, "s", $43, "    Vas Jozsef "
        .byte "   Ir", $20, "ny", $3c, "t", $20, "s", $43, "        joystick   "
        .byte "   L", $3d, "v", $3b, "s", $43, "           FIRE gomb   "
;------------------------
DEMOTXT .byte "       Nyomd meg a FIRE gombot", $42, $42, $42, "       "
;------------------------         
COTX    .byte $60, $60, $60, $60, $60, $60, $60, $60
        .byte $60, $60, $60, $60, $60, $60, $60, $60
        .byte $60, $60, $60, $60, $60, $60, $60, $60
        .byte $60, $60, $60, $60, $60, $60, $60, $60
        
        .byte $60, "                              ", $60
        .byte $60, "          GRATULALUNK", $44, "        ", $60
        .byte $60, "                              ", $60
        .byte $60, "     Robbonak    siker", $7b, "lt     ", $60
        .byte $60, " elmenelk", $7b, "lnie a rendszerb", $3f, "l", $42, " ", $60
        .byte $60, "     A  mem", $3e, "ri", $20, "j", $20, "ban   ", $3f, "rz", $3d, "tt ", $60
        .byte $60, " tervek nagyon ", $3b, "rt", $3b, "kesek", $42, "     ", $60
        .byte $60, "                              ", $60
        .byte $60, "  Bejezted az els", $3f, " j", $20, "t", $3b, "kunkat ", $60
        .byte $60, " Ha  tetszett", $41, "   pr", $3e, "b", $20, "ld   ki ", $60
        .byte $60, " a k", $3d, "vetkez", $3f, "t is", $44, "             ", $60
        .byte $60, "                              ", $60
        .byte $60, "  Vegy", $3b, "l r", $3b, "szt a versenyben", $44,"  ", $60
        .byte $60, "                              ", $60
        .byte $60, "  K", $7b, "ldd el  a titkos jelsz", $3e, "t  ", $60
        .byte $60, "         ABCDEFGHIJKL         ", $60
        .byte $60, "  a robbo", $5b, "tdididit", $42, "com c", $3c, "mre  ", $60
        .byte $60, "                              ", $60

        .byte $60, $60, $60, $60, $60, $60, $60, $60
        .byte $60, $60, $60, $60, $60, $60, $60, $60
        .byte $60, $60, $60, $60, $60, $60, $60, $60
        .byte $60, $60, $60, $60, $60, $60, $60, $60
;------------------------
INST:   .byte "           "," "+$80, "U"+$80,"t"+$80,"m"+$80,"u"+$80,"t"+$80,"a"+$80,"t"+$80, $3e+$80," "+$80, $40, $40
;        .byte $ff
        .byte "   Robbo", $1f, "ra egy neh", $3b, "z utaz", $20, "s v", $20, "r"
        .byte $1a, $1b, "  plan", $3b, "t", $20, "n   kereszt", $7b, "l", $41, "   hogy"
        .byte "kijusson      egy     ellens", $3b, "ges"
        .byte "bolyg", $3e, "rendszerb", $3f, "l", $41, "      ahol    "
        .byte "alattomosan csapd", $20, "ba ejtett", $3b, "k", $42, $40, $40

        .byte "   Minden egyes  bolyg", $3e, "n egy kis"
        .byte "kapszula      v", $20, "rja", $41, "      amivel"
        .byte "a k", $3d, "vetkez", $3f, "  bolyg", $3e, "ra  rep", $7b, "lhet", $42

        .byte "A   legt", $3d, "bb   kapszula   azonban"
        .byte "sajnos  hi", $20, "nyos", $41, "  ", $3c, "gy  Robbo", $1f, "nak"
        .byte $3d, "ssze kell gy", $7c, "jtenie a megfelel", $3f
        .byte "cserealkatr", $3b, "szeket", $41, "     amik", $40
        .byte "sz", $3b, "tsz", $3e, "rva hevernek a bolyg", $3e, "n", $42, $40
        .byte "Gonosz l", $3b, "nyek akad", $20, "lyozz", $20, "k ebben"
        .byte "             ", $1f, " a rendszer lak", $3e, "i", $42
        .byte "Az utaz", $20, "sa alatt Robbo k", $7b, "l", $3d, "nb", $3d, "z", $3f
        .byte "dolgokat fog tal", $20, "lni", $42,  " Tal", $20, "ld ki", $41
        .byte "mit kell vel", $7b, "k csin", $20, "lni", $42,  " Pr", $3e, "b", $20, "ld"
        .byte "meg  elmozd", $3c, "tani", $41, "  ", $3d, "sszegy", $7c, "jteni"
        .byte $3f, "ket vagy r", $20, "juk l", $3f, "ni", $42, $40, $40

        .byte "  Ha Robbo rem", $3b, "nytelen helyzetbe" 
        .byte "ker", $7b, "l", $41, "  csak nyomd meg a ", " "+$80,"R"+$80,"E"+$80,"S"+$80,"E"+$80,"T"+$80," "+$80
        .byte "gombot", $42, $40, $40

        .byte "Eml", $3b, "kezz r", $20, $41, " hogy minden bolyg", $3e, "t"
        .byte "el lehet hagyni", $44, $40, $40

        .byte "J", $3e, " sz", $3e, "rakoz", $20, "st k", $3c, "v", $20, "nnak", $40
        .byte "             a program k", $3b, "sz", $3c, "t", $3f, "i", $42, $40, $40


        .byte "   Ha  siker", $7b, "lt  kereszt", $7b, "ljutnod" 
        .byte "az eg", $3b, "sz  bolyg", $3e, "rendszeren", $41, "  ", $3c, "rj"
        .byte "nek", $7b, "nk  ", $3b, "s  mondd el  v", $3b, "lem", $3b, "nyed" 
        .byte "a  j", $20, "t", $3b, "k  v", $3b, "g", $3b, "r", $3f, "l", $42, "  Az  els", $3f, "  ", $3d, "t" 
        .byte "bek", $7b, "ld", $3f, "    jutalma     k", $3d, "vetkez", $3f
        .byte "j", $20, "t", $3b, "kunk   egy", $1f, "egy    k", $7b, "l", $3d, "nleges"
        .byte "p", $3b, "ld", $20, "nya lesz", $42, $40
;        .byte "                                "

        .byte $40, $40, $40, $40, $40
        .byte $40, $40, $ff
.ENDL
