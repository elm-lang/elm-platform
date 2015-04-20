On Error Resume Next

Set WshShell = CreateObject("WScript.Shell")
elmPath = WScript.Arguments(0)
'const PathRegKey = "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment\Path"
const PathRegKey = "HKCU\Environment\Path"
newPath = elmPath
path = WshShell.RegRead(PathRegKey)
If Err.Number = 0 Then ' If key exists, append current path
    newPath = elmPath & ";" & path
End If
Call WshShell.RegWrite(PathRegKey, newPath)
