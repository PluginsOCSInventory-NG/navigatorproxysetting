'Author: Valentin DEVILLE & MTeck (Stackoverflow)

Set shell = WScript.CreateObject("WScript.Shell")
proxyEnable = shell.RegRead ("HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\ProxyEnable")
proxyServerKey = "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\ProxyServer"
proxyOverrideKey = "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\ProxyOverride"
autoConfigURLKey = "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\AutoConfigURL"
'detectAutoKey = "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Connections\DefaultConnectionSettings"

on error resume next
proxyServer = shell.RegRead(proxyServerKey)

if err.number<>0 then
    if right(proxyServerKey,1)="\" then
        if instr(1,err.description,ssig,1)<>0 then
            bExists=true
        else
            bExists=false
        end if
    else
        bExists=false
    end if
    err.clear
else
    bExists=true
end if
on error goto 0
if bExists=vbFalse then
    proxyServer = "None"
end if


on error resume next
autoConfigURL = shell.RegRead(autoConfigURLKey)

if err.number<>0 then
    if right(autoConfigURLKey,1)="\" then
        if instr(1,err.description,ssig,1)<>0 then
            bExists=true
        else
            bExists=false
        end if
    else
        bExists=false
    end if
    err.clear
else
    bExists=true
end if
on error goto 0
if bExists=vbFalse then
    autoConfigURL = "None"
end if

proxyOverride = shell.RegRead(proxyOverrideKey)

Wscript.Echo "<NAVIGATORPROXYSETTING>"
Wscript.Echo "<ENABLE>" & proxyEnable & "</ENABLE>"
Wscript.Echo "<AUTOCONFIGURL>" & autoConfigURL & "</AUTOCONFIGURL>"
Wscript.Echo "<ADDRESS>" & proxyServer & "</ADDRESS>"
Wscript.Echo "<OVERRIDE>" & proxyOverride & "</OVERRIDE>"
Wscript.Echo "</NAVIGATORPROXYSETTING>"