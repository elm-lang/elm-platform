
set version=%1

runhaskell ..\BuildFromSource.hs %version%

mkdir files
mkdir files\bin
mkdir files\share
mkdir files\share\compiler
mkdir files\share\reactor

set platform=Elm-Platform\%version%

xcopy %platform%\bin\elm*.exe files\bin /s /e
xcopy %platform%\Elm\data\* files\share\compiler /s /e
xcopy %platform%\elm-reactor\assets\* files\share\reactor /s /e

"%ProgramFiles%\NSIS\makensis.exe" /DPLATFORM_VERSION=%version% Nsisfile.nsi

rd /s /q files
