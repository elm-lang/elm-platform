set CABAL_DIR=%APPDATA%\cabal

set ELM_VERSION_CMD="%CABAL_DIR%\bin\elm.exe -v"
for /f %%i in (' %ELM_VERSION_CMD% ') do set ELM_VERSION=%%i

mkdir files
mkdir files\bin
mkdir files\share

copy %CABAL_DIR%\bin\elm.exe files\bin
copy %CABAL_DIR%\bin\elm-doc.exe files\bin
copy %CABAL_DIR%\bin\elm-get.exe files\bin
copy %CABAL_DIR%\bin\elm-server.exe files\bin

copy %CABAL_DIR%\Elm-%ELM_VERSION%\docs.json files\share
copy %CABAL_DIR%\Elm-%ELM_VERSION%\elm-runtime.js files\share
copy %CABAL_DIR%\Elm-%ELM_VERSION%\interfaces.data files\share
