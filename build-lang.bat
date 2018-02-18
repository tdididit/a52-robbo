bin\mads.exe inc\lang-pl.asm -d:TEXT_RAM=$3000 -o:raw\lang-pl.bin
bin\deflater.exe raw/lang-pl.bin raw/lang-pl.def

bin\mads.exe inc\lang-hu.asm -d:TEXT_RAM=$3000 -o:raw\lang-hu.bin
bin\deflater.exe raw/lang-hu.bin raw/lang-hu.def

bin\mads.exe inc\lang-en.asm -d:TEXT_RAM=$3000 -o:raw\lang-en.bin
bin\deflater.exe raw/lang-en.bin raw/lang-en.def

bin\mads.exe inc\lang-de.asm -d:TEXT_RAM=$3000 -o:raw\lang-de.bin
bin\deflater.exe raw/lang-de.bin raw/lang-de.def




