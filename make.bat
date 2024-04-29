REM delete previous files
DEL .\build\*.gb

REM compile .c files into .o files
.\dependencies\gbdk\bin\lcc -c -o .\src\main.o .\src\main.c


REM Compile a .gb file from the compiled .o files
.\dependencies\gbdk\bin\lcc  -o .\build\CrownSimulator.gb .\src\main.o

REM exit successfully