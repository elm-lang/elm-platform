Set WshShell = CreateObject("WScript.Shell")
' Make sure there is no trailing slash at the end of elmBasePath
elmBasePath = WScript.Arguments(0)
'const PathRegKey = "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment\Path"
const PathRegKey = "HKCU\Environment\Path"
path = WshShell.RegRead(PathRegKey)
Set regEx = New RegExp
elmBasePath = Replace(Replace(Replace(elmBasePath, "\", "\\"), "(", "\("), ")", "\)")
regEx.Pattern = elmBasePath & "\\\d+\.\d+(\.\d+|)\\bin(;|)"
regEx.Global = True
newPath = regEx.Replace(path, "")
Call WshShell.RegWrite(PathRegKey, newPath, "REG_EXPAND_SZ")
