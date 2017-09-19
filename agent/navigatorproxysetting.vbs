'----------------------------------------------------------
' Plugin for OCS Inventory NG 2.x
' Script :		Navigator proxy settings
' Version :		1.00
' Date :		27/03/2017
' Authors :		Valentin DEVILLE & MTeck (Stackoverflow)
'----------------------------------------------------------
' OS checked [X] on	32b	64b	(Professionnal edition)
'	Windows XP	[X]
'	Windows Vista	[X]	[X]
'	Windows 7	[X]	[X]
'	Windows 8.1	[X]	[X]	
'	Windows 10	[X]	[X]
'	Windows 2k8R2		[X]
'	Windows 2k12R2		[X]
'	Windows 2k16		[X]
' ---------------------------------------------------------
' NOTE : No checked on Windows 8
' ---------------------------------------------------------
On Error Resume Next

const HKEY_USERS = &H80000003
strComputer = "."
PUBLIC strUsers, UserName

Function StripAccents(str)
	accent   = "ÈÉÊËÛÙÏÎÀÂÔÖÇèéêëûùïîàâôöç"
	noaccent = "EEEEUUIIAAOOCeeeeuuiiaaooc"
	currentChar = ""
	result = ""
	k = 0
	o = 0

	For k = 1 To len(str)
		currentChar = mid(str,k, 1)
		o = InStr(1, accent, currentChar, 1)
		If o > 0 Then
			result = result & mid(noaccent,o,1)
		Else
			result = result & currentChar
		End If
	Next
	StripAccents = result
End Function
	
On Error Resume Next
Set objWMIService = GetObject("winmgmts:\\" & strComputer & "\root\cimv2")


Set StdOut = WScript.StdOut
Set oReg=GetObject("winmgmts:{impersonationLevel=impersonate}!\\" & strComputer &  "\root\default:StdRegProv")
strKeyPath = ""
oReg.EnumKey HKEY_USERS, strKeyPath, arrKeys
For Each key In arrKeys
'len(key) > 35 AND
	If Instr(key,"Classes") = 0 Then
		'key = SID
		Set objAccount = objWMIService.Get("Win32_SID.SID='" & key & "'")
		UserName = objAccount.AccountName
		'Set objNetwork = CreateObject("WScript.Network")
		'Set objShell = CreateObject("WScript.Shell")
		'Set objWMIService = GetObject("winmgmts:\\.\root\cimv2")
		'Set objAccount = objWMIService.Get("Win32_UserAccount.Name='" & objNetwork.UserName & "',Domain='" & objNetwork.UserDomain & "'")
		If UserName <> "" then

			Set shell = WScript.CreateObject("WScript.Shell")
			proxyEnable = shell.RegRead ("HKEY_USERS\"& key &"\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\ProxyEnable")
			proxyServerKey = "HKEY_USERS\"& key &"\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\ProxyServer"
			proxyOverrideKey = "HKEY_USERS\"& key &"\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\ProxyOverride"
			autoConfigURLKey = "HKEY_USERS\"& key &"\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\AutoConfigURL"
			'detectAutoKey = "HKEY_USERS\"& key &"\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Connections\DefaultConnectionSettings"

			proxyServer = shell.RegRead(proxyServerKey)

			If err.number<>0 then
				If right(proxyServerKey,1)="\" then
					If instr(1,err.description,ssig,1)<>0 then
						bExists=true
					Else
						bExists=false
					End if
				Else
					bExists=false
				End if
            err.clear
		Else
            bExists=true
        End if
        On error goto 0
        If bExists=vbFalse then
            proxyServer = "None"
        End if

		On Error Resume Next
        autoConfigURL = shell.RegRead(autoConfigURLKey)

        If err.number<>0 then
            If right(autoConfigURLKey,1)="\" then
                If instr(1,err.description,ssig,1)<>0 then
                    bExists=true
                Else
                    bExists=false
                End if
            Else
                bExists=false
            End if
            err.clear
		Else
			bExists=true
		End if
		on error goto 0
		If bExists=vbFalse then
			autoConfigURL = "None"
		End if

		On Error Resume Next
		proxyOverride = shell.RegRead(proxyOverrideKey)

        Wscript.Echo _
			"<NAVIGATORPROXYSETTING>" & VbCrLf &_
			"<USER>" & StripAccents(UserName) & "</USER>" & VbCrLf &_
			"<ENABLE>" & proxyEnable & "</ENABLE>" & VbCrLf &_
			"<AUTOCONFIGURL>" & autoConfigURL & "</AUTOCONFIGURL>" & VbCrLf &_
			"<ADDRESS>" & proxyServer & "</ADDRESS>" & VbCrLf &_
			"<OVERRIDE>" & proxyOverride & "</OVERRIDE>" & VbCrLf &_
			"</NAVIGATORPROXYSETTING>"
		End If
	End If
Next
