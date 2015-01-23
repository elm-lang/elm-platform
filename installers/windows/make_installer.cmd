
set version=%1

runhaskell ..\BuildFromSource.hs %version%
if %errorlevel% neq 0 exit /b %errorlevel%

mkdir files
mkdir files\bin
mkdir files\share
mkdir files\share\compiler
mkdir files\share\reactor

set platform=Elm-Platform\%version%

xcopy %platform%\bin\elm*.exe files\bin /s /e
xcopy %platform%\Elm\data\* files\share\compiler /s /e
xcopy %platform%\elm-reactor\assets\* files\share\reactor /s /e
xcopy updatepath.vbs files

if EXIST "%ProgramFiles%" (
    set nsis=%ProgramFiles%\NSIS
) else (
    set nsis=%ProgramFiles(x86)%\NSIS
)

"%nsis%\makensis.exe" /DPLATFORM_VERSION=%version% Nsisfile.nsi

rd /s /q files
