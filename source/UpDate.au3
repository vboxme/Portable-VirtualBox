; AutoIt Version : 3.3.6.1
; AutoIt Compiler: 3.3.6.1
; Language       : multilanguage
; Author         : Michael Meyer (michaelm_007)
; e-Mail         : email.address@gmx.de
; License        : http://creativecommons.org/licenses/by-nc-sa/3.0/
; Version        : 1.0.0
; Download       : http://www.vbox.me
; Support        : http://www.win-lite.de/wbb/index.php?page=Board&boardID=153

#NoTrayIcon
#RequireAdmin

Sleep (2000)

FileMove (@ScriptDir&"\Portable-VirtualBox.exe", @ScriptDir&"\Portable-VirtualBox.exe_BAK", 9)
FileMove (@ScriptDir&"\Portable-VirtualBox.exe_NEW", @ScriptDir&"\Portable-VirtualBox.exe", 9)

Sleep (2000)

Run (@ScriptDir&"\Portable-VirtualBox.exe")

Break (1)
Exit