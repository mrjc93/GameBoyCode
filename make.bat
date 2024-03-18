REM delete previous files
DEL *.gb

REM compile .c files into .o files
C:\gbdk\bin\lcc -c -o main.o main.c


REM Compile a .gb file from the compiled .o files
C:\GBDK\bin\lcc  -o CrownSimulator.gb main.o

