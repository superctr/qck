rem ca65 -l test.lst -t nes testing.asm
rem ld65 -t nes testing.o
cl65 -l test2.lst -g -t nes -C quattro.cfg  -m qt.map -o custom.bin custom.asm