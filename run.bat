set isbuildrequired=%1
if "%isbuildrequired%"=="rebuild" (
    call make.bat
)
start .\dependencies\bgbw\bgb.exe -rom .\build\CrownSimulator.gb