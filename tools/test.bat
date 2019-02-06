@echo off
mingw32-gcc.exe -g -o wavtest.exe wavtest.c fileio.c ini.c
wavtest test.ini out.s out.bin