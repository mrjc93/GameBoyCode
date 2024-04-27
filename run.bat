set isbuildrequired=%1
if "%isbuildrequired%"=="rebuild" (
    call make.bat
)
start .\dependencies\bgbw\bgb64.exe -rom .\build\CrownSimulator.gb