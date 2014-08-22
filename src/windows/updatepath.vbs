Set WshShell = CreateObject("WScript.Shell")
elmPath = WScript.Arguments(0)
'const PathRegKey = "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment\Path"
const PathRegKey = "HKCU\Environment\Path"
path = WshShell.RegRead(PathRegKey)
newPath = elmPath & ";" & path
Call WshShell.RegWrite(PathRegKey, newPath)
