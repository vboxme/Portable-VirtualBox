; Language       : multilanguage
; Author         : Michael Meyer (michaelm_007) et al.
; e-Mail         : email.address@gmx.de
; License        : http://creativecommons.org/licenses/by-nc-sa/3.0/
; Version        : 6.4.9.0
; Download       : http://www.vbox.me
; Support        : http://www.win-lite.de/wbb/index.php?page=Board&boardID=153

#AutoIt3Wrapper_Res_Fileversion=6.4.9.0
#AutoIt3Wrapper_Res_ProductVersion=6.4.9.0
#AutoIt3Wrapper_Icon=VirtualBox.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_Compile_both=Y

#include <ColorConstants.au3>
#include <Constants.au3>
#include <GUIConstantsEx.au3>
#include <DirConstants.au3>
#include <FileConstants.au3>
#include <IE.au3>
#include <ProcessConstants.au3>
#include <String.au3>
#include <WinAPIError.au3>

#NoTrayIcon
#RequireAdmin

Opt ("GUIOnEventMode", 1)
Opt ("TrayAutoPause", 0)
Opt ("TrayMenuMode", 11)
Opt ("TrayOnEventMode", 1)

TraySetClick (16)
TraySetState ()
TraySetToolTip ("Portable-VirtualBox")

Global $version = "6.4.9.0"
Global $var1 = @ScriptDir&"\data\settings\settings.ini"
Global $var2 = @ScriptDir&"\data\language\"
Global $lng = IniRead ($var1, "language", "key", "NotFound")
Global $pwd = @ScriptDir
Global $updateUrl = IniRead (@ScriptDir&"\data\settings\vboxinstall.ini", "download", "update", "NotFound")

Global $new1 = 0, $new2 = 0

If FileExists (@ScriptDir&"\update.exe") Then
  Sleep (2000)
  DirRemove (@ScriptDir&"\update", 1)
  FileDelete (@ScriptDir&"\update.exe")
EndIf

If NOT FileExists ($var1) Then
  DirCreate (@ScriptDir&"\data\settings")
  IniWrite ($var1, "hotkeys", "key", "1")
  IniWrite ($var1, "hotkeys", "userkey", "0")

  IniWrite ($var1, "hotkeys", "01", "^")
  IniWrite ($var1, "hotkeys", "02", "^")
  IniWrite ($var1, "hotkeys", "03", "^")
  IniWrite ($var1, "hotkeys", "04", "^")
  IniWrite ($var1, "hotkeys", "05", "^")
  IniWrite ($var1, "hotkeys", "06", "^")

  IniWrite ($var1, "hotkeys", "07", "")
  IniWrite ($var1, "hotkeys", "08", "")
  IniWrite ($var1, "hotkeys", "09", "")
  IniWrite ($var1, "hotkeys", "10", "")
  IniWrite ($var1, "hotkeys", "11", "")
  IniWrite ($var1, "hotkeys", "12", "")

  IniWrite ($var1, "hotkeys", "13", "")
  IniWrite ($var1, "hotkeys", "14", "")
  IniWrite ($var1, "hotkeys", "15", "")
  IniWrite ($var1, "hotkeys", "16", "")
  IniWrite ($var1, "hotkeys", "17", "")
  IniWrite ($var1, "hotkeys", "18", "")

  IniWrite ($var1, "hotkeys", "19", "1")
  IniWrite ($var1, "hotkeys", "20", "2")
  IniWrite ($var1, "hotkeys", "21", "3")
  IniWrite ($var1, "hotkeys", "22", "4")
  IniWrite ($var1, "hotkeys", "23", "5")
  IniWrite ($var1, "hotkeys", "24", "6")

  IniWrite ($var1, "usb", "key", "0")

  IniWrite ($var1, "net", "key", "0")

  IniWrite ($var1, "language", "key", "english")

  IniWrite ($var1, "userhome", "key", "%CD%\data\.VirtualBox")

  IniWrite ($var1, "startvm", "key", "")

  IniWrite ($var1, "update", "key", "1")

  IniWrite ($var1, "lang", "key", "0")

  IniWrite ($var1, "version", "key", "")

  IniWrite ($var1, "starter", "key", "")
Else
  IniReadSection ($var1, "update")
  If @error Then
    IniWrite ($var1, "update", "key", "1")
  EndIf

  IniReadSection ($var1, "lang")
  If @error Then
    IniWrite ($var1, "lang", "key", "0")
  EndIf

  IniReadSection ($var1, "version")
  If @error Then
    IniWrite ($var1, "version", "key", "")
  EndIf

  IniReadSection ($var1, "starter")
  If @error Then
    IniWrite ($var1, "starter", "key", "")
  EndIf
EndIf

If IniRead ($var1, "lang", "key", "NotFound") = 0 Then
  Global $cl = 1, $StartLng

  Local $WS_POPUP

  GUICreate ("Language", 300, 136, -1, -1, $WS_POPUP)
  GUISetFont (9, 400, 0, "Arial")
  GUISetBkColor (0xFFFFFF)
  GUICtrlSetFont (-1, 10, 800, 0, "Arial")

  GUICtrlCreateLabel ("Please select your language", 14, 8, 260, 14)
  GUICtrlSetFont (-1, 9, 800, "Arial")

  $StartLng = GUICtrlCreateInput (IniRead ($var1, "language", "key", "NotFound"), 13, 34, 180, 21)

  GUICtrlCreateButton ("Search", 200, 32, 80, 24, 0)
  GUICtrlSetOnEvent (-1, "SRCLanguage")
  GUICtrlCreateButton ("OK", 30, 66, 100, 28, 0)
  GUICtrlSetOnEvent (-1, "OKLanguage")
  GUICtrlCreateButton ("Exit", 162, 66, 100, 28, 0)
  GUICtrlSetOnEvent (-1, "ExitGUI")

  GUISetState ()

  While 1
    If $cl = 0 Then ExitLoop
  WEnd

  GUIDelete ()

  IniWrite ($var1, "lang", "key", "1")
EndIf

$lng = IniRead ($var1, "language", "key", "NotFound")

If IniRead ($var1, "update", "key", "NotFound") = 1 Then
  Local $hDownload = InetGet ($updateUrl&"update.dat", @TempDir&"\update.ini", 1, 1)
  Do
    Sleep (250)
  Until InetGetInfo ($hDownload, 2)
  InetClose ($hDownload)
EndIf

If FileExists (@TempDir&"\update.ini") Then
  If IniRead (@TempDir&"\update.ini", "version", "key", "NotFound") <= IniRead (@ScriptDir&"\data\settings\settings.ini", "version", "key", "NotFound") Then
    $new1 = 0
  Else
    $new1 = 1
  Endif

  If IniRead (@TempDir&"\update.ini", "starter", "key", "NotFound") <= IniRead (@ScriptDir&"\data\settings\settings.ini", "starter", "key", "NotFound") Then
    $new2 = 0
  Else
    $new2 = 1
  Endif
EndIf

If $new1 = 1 OR $new2 = 1 Then
  Global $Input300, $Checkbox200
  Global $update = 1

  Local $ov = IniRead ($var1, "version", "key", "NotFound")
  Local $os = IniRead ($var1, "starter", "key", "NotFound")
  Local $nv = IniRead (@TempDir&"\update.ini", "version", "key", "NotFound")
  Local $ns = IniRead (@TempDir&"\update.ini", "starter", "key", "NotFound")

  Local $ovd1 = StringTrimRight($ov, 3)
  Local $ovd2 = StringTrimLeft($ov, 1)
  Local $ovd3 = StringTrimRight($ovd2, 2)
  Local $ovd4 = StringTrimLeft($ov, 2)
  Local $ovd5 = StringTrimRight($ovd4, 1)
  Local $ovd6 = StringTrimLeft($ov, 3)

  Local $osd1 = StringTrimRight($os, 3)
  Local $osd2 = StringTrimLeft($os, 1)
  Local $osd3 = StringTrimRight($osd2, 2)
  Local $osd4 = StringTrimLeft($os, 2)
  Local $osd5 = StringTrimRight($osd4, 1)
  Local $osd6 = StringTrimLeft($os, 3)

  Local $nvd1 = StringTrimRight($nv, 3)
  Local $nvd2 = StringTrimLeft($nv, 1)
  Local $nvd3 = StringTrimRight($nvd2, 2)
  Local $nvd4 = StringTrimLeft($nv, 2)
  Local $nvd5 = StringTrimRight($nvd4, 1)
  Local $nvd6 = StringTrimLeft($nv, 3)

  Local $nsd1 = StringTrimRight($ns, 3)
  Local $nsd2 = StringTrimLeft($ns, 1)
  Local $nsd3 = StringTrimRight($nsd2, 2)
  Local $nsd4 = StringTrimLeft($ns, 2)
  Local $nsd5 = StringTrimRight($nsd4, 1)
  Local $nsd6 = StringTrimLeft($ns, 3)

  If $ovd5 = 0 Then
    Local $ov_d = "v"& $ovd1 &"."& $ovd3 &"."& $ovd6
  Else
    Local $ov_d = "v"& $ovd1 &"."& $ovd3 &"."& $ovd5 &"."& $ovd6
  EndIf

  If $nsd5 = 0 Then
    Local $os_d = "v"& $osd1 &"."& $osd3 &"."& $osd6
  Else
    Local $os_d = "v"& $osd1 &"."& $osd3 &"."& $osd5 &"."& $osd6
  EndIf

  If $nvd5 = 0 Then
    Local $nv_d = "v"& $nvd1 &"."& $nvd3 &"."& $nvd6
  Else
    Local $nv_d = "v"& $nvd1 &"."& $nvd3 &"."& $nvd5 &"."& $nvd6
  EndIf

  If $nsd5 = 0 Then
    Local $ns_d = "v"& $nsd1 &"."& $nsd3 &"."& $nsd6
  Else
    Local $ns_d = "v"& $nsd1 &"."& $nsd3 &"."& $nsd5 &"."& $nsd6
  EndIf

  Local $WS_POPUP

  If $new1 = 1 AND $new2 = 0 Then
    Local $dialog = IniRead ($var2 & $lng &".ini", "check", "02", "NotFound") &" "& $ov_d &" "& IniRead ($var2 & $lng &".ini", "check", "06", "NotFound") &" "& $nv_d &" "& IniRead ($var2 & $lng &".ini", "check", "07", "NotFound")
  EndIf

  If $new1 = 0 AND $new2 = 1 Then
    Local $dialog = IniRead ($var2 & $lng &".ini", "check", "03", "NotFound") &" "& $os_d &" "& IniRead ($var2 & $lng &".ini", "check", "06", "NotFound") &" "& $ns_d &" "& IniRead ($var2 & $lng &".ini", "check", "07", "NotFound")
  EndIf

  If $new1 = 1 AND $new2 = 1 Then
    Local $dialog = IniRead ($var2 & $lng &".ini", "check", "04", "NotFound") &" "& $ov_d &" "& IniRead ($var2 & $lng &".ini", "check", "06", "NotFound") &" "& $nv_d &" "& IniRead ($var2 & $lng &".ini", "check", "05", "NotFound") &" "& $os_d &" "& IniRead ($var2 & $lng &".ini", "check", "06", "NotFound") &" "& $ns_d &" "& IniRead ($var2 & $lng &".ini", "check", "07", "NotFound")
  EndIf

  GUICreate (IniRead ($var2 & $lng &".ini", "check", "01", "NotFound"), 300, 190, -1, -1, $WS_POPUP)
  GUISetFont (9, 400, 0, "Arial")
  GUISetBkColor (0xFFFFFF)
  GUICtrlSetFont (-1, 10, 800, 0, "Arial")

  GUICtrlCreateLabel ($dialog, 14, 8, 260, 50)
  GUICtrlSetFont (-1, 9, 800, "Arial")

  $Checkbox200 = GUICtrlCreateCheckbox (IniRead ($var2 & $lng &".ini", "check", "08", "NotFound"), 14, 62, 260, 14)

  GUICtrlCreateLabel (IniRead ($var2 & $lng &".ini", "check", "09", "NotFound"), 14, 82, 280, 10)
  GUICtrlSetFont (-1, 8, 800, 4,"Arial")
  $Input300 = GUICtrlCreateLabel ("", 14, 96, 260, 20)
  GUICtrlSetFont (-1, 8, 400, 0,"Arial")

  GUICtrlCreateButton (IniRead ($var2 & $lng &".ini", "check", "10", "NotFound"), 32, 116, 100, 33, 0)
  GUICtrlSetFont (-1, 9, 800, "Arial")
  GUICtrlSetOnEvent (-1, "UpdateYes")
  GUICtrlCreateButton (IniRead ($var2 & $lng &".ini", "check", "11", "NotFound"), 160, 116, 100, 33, 0)
  GUICtrlSetFont (-1, 9, 800, "Arial")
  GUICtrlSetOnEvent (-1, "UpdateNo")

  GUISetState ()

  While 1
    If $update = 0 Then ExitLoop
  WEnd
EndIf

If IniRead (@ScriptDir&"\data\settings\settings.ini", "update", "key", "NotFound") = 1 Then
  Sleep (2000)
  FileDelete (@TempDir&"\update.ini")
EndIf

; Thibaut : use Hybrid Mode if available
HybridMode()

If NOT (FileExists (@ScriptDir&"\app32") OR FileExists (@ScriptDir&"\app64")) Then
  Global $Checkbox100, $Checkbox110, $Checkbox130;, $Checkbox120
  Global $Input100, $Input200
  Global $install = 1

  Local $WS_POPUP

  GUICreate (IniRead ($var2 & $lng &".ini", "download", "01", "NotFound"), 542, 380, -1, -1, $WS_POPUP)
  GUISetFont (9, 400, 0, "Arial")
  GUISetBkColor (0xFFFFFF)
  GUICtrlSetFont (-1, 10, 800, 0, "Arial")

  GUICtrlCreateLabel (IniRead ($var2 & $lng &".ini", "download", "02", "NotFound"), 32, 8, 476, 60)
  GUICtrlSetFont (-1, 9, 800, "Arial")

  GUICtrlCreateButton (IniRead ($var2 & $lng &".ini", "download", "03", "NotFound"), 32, 62, 473, 33)
  GUICtrlSetFont (-1, 14, 400, "Arial")
  GUICtrlSetOnEvent (-1, "DownloadFile")

  GUICtrlCreateLabel (IniRead ($var2 & $lng &".ini", "download", "04", "NotFound"), 250, 101, 80, 40)
  GUICtrlSetFont (-1, 10, 800, "Arial")

  $Input100 = GUICtrlCreateInput (IniRead ($var2 & $lng &".ini", "download", "05", "NotFound"), 32, 124, 373, 21)
  GUICtrlCreateButton (IniRead ($var2 & $lng &".ini", "download", "06", "NotFound"), 412, 122, 93, 25, 0)
  GUICtrlSetOnEvent (-1, "SearchFile")

  $Checkbox100 = GUICtrlCreateCheckbox (IniRead ($var2 & $lng &".ini", "download", "07", "NotFound"), 32, 151, 460, 26)
  $Checkbox110 = GUICtrlCreateCheckbox (IniRead ($var2 & $lng &".ini", "download", "08", "NotFound"), 32, 175, 460, 26)
  ;$Checkbox120 = GUICtrlCreateCheckbox (IniRead ($var2 & $lng &".ini", "download", "09", "NotFound"), 32, 199, 460, 26)
  $Checkbox130 = GUICtrlCreateCheckbox (IniRead ($var2 & $lng &".ini", "download", "10", "NotFound"), 32, 223, 460, 26)

  GUICtrlCreateLabel (IniRead ($var2 & $lng &".ini", "download", "11", "NotFound"), 32, 247, 436, 26)
  GUICtrlSetFont (-1, 8, 800, 4,"Arial")
  $Input200 = GUICtrlCreateLabel ("", 32, 264, 476, 47)
  GUICtrlSetFont (-1, 8, 400, 0,"Arial")

  GUICtrlCreateButton (IniRead ($var2 & $lng &".ini", "download", "12", "NotFound"), 52, 308, 129, 33, 0)
  GUICtrlSetOnEvent (-1, "UseSettings")
  GUICtrlCreateButton (IniRead ($var2 & $lng &".ini", "download", "13", "NotFound"), 194, 308, 149, 33, 0)
  GUICtrlSetFont (-1, 8, 600, "Arial")
  GUICtrlSetOnEvent (-1, "Licence")
  GUICtrlCreateButton (IniRead ($var2 & $lng &".ini", "download", "14", "NotFound"), 356, 308, 129, 33, 0)
  GUICtrlSetOnEvent (-1, "ExitExtraction")

  GUISetState ()

  While 1
    If $install = 0 Then ExitLoop
  WEnd

  Global $startvbox = 0
Else
  Global $startvbox = 1
EndIf

If (FileExists (@ScriptDir&"\app32\virtualbox.exe") OR FileExists (@ScriptDir&"\app64\virtualbox.exe")) AND ($startvbox = 1 OR IniRead (@ScriptDir&"\data\settings\vboxinstall.ini", "startvbox", "key", "NotFound") = 1) Then
  If FileExists (@ScriptDir&"\app32\") AND FileExists (@ScriptDir&"\app64\") Then
    If @OSArch = "x86" Then
      Global $arch = "app32"
    EndIf
    If @OSArch = "x64" Then
      Global $arch = "app64"
    EndIf
  Else
    If FileExists (@ScriptDir&"\app32\") AND NOT FileExists (@ScriptDir&"\app64\") Then
      Global $arch = "app32"
    EndIf
    If NOT FileExists (@ScriptDir&"\app32\") AND FileExists (@ScriptDir&"\app64\") Then
      Global $arch = "app64"
    EndIf
  EndIf

  If FileExists (@ScriptDir&"\data\.VirtualBox\VirtualBox.xml-prev") Then
    FileDelete (@ScriptDir&"\data\.VirtualBox\VirtualBox.xml-prev")
  EndIf

  If FileExists (@ScriptDir&"\data\.VirtualBox\VirtualBox.xml-tmp") Then
    FileDelete (@ScriptDir&"\data\.VirtualBox\VirtualBox.xml-tmp")
  EndIf

  If FileExists (@ScriptDir&"\data\.VirtualBox\VirtualBox.xml") OR (FileExists (@ScriptDir&"\data\.VirtualBox\Machines\") AND FileExists (@ScriptDir&"\data\.VirtualBox\HardDisks\")) Then
    Local $values0, $values1, $values2, $values3, $values4, $values5, $values6, $values7, $values8, $values9, $values10, $values11, $values12, $values13
    Local $line, $content, $i, $j, $k, $l, $m, $n
    Local $file = FileOpen (@ScriptDir&"\data\.VirtualBox\VirtualBox.xml", 128)
    If $file <> -1 Then
      $line    = FileRead ($file)
      $values0 = _StringBetween ($line, '<MachineRegistry>', '</MachineRegistry>')
      If $values0 = 0 Then
        $values1 = 0
      Else
        $values1 = _StringBetween ($values0[0], 'src="', '"')
      EndIf
      $values2 = _StringBetween ($line, '<HardDisks>', '</HardDisks>')
      If $values2 = 0 Then
        $values3 = 0
      Else
        $values3 = _StringBetween ($values2[0], 'location="', '"')
      EndIf
      $values4 = _StringBetween ($line, '<DVDImages>', '</DVDImages>')
      If $values4 = 0 Then
        $values5 = 0
      Else
        $values5 = _StringBetween ($values4[0], '<Image', '/>')
      EndIf
      $values10 = _StringBetween ($line, '<Global>', '</Global>')
      If $values10 = 0 Then
        $values11 = 0
      Else
        $values11 = _StringBetween ($values10[0], '<SystemProperties', '/>')
      EndIf

      For $i = 0 To UBound ($values1) - 1
        $values6 = _StringBetween ($values1[$i], 'Machines', '.vbox')
        If $values6 <> 0 Then
          $content = FileRead (FileOpen (@ScriptDir&"\data\.VirtualBox\VirtualBox.xml", 128))
          $file    = FileOpen (@ScriptDir&"\data\.VirtualBox\VirtualBox.xml", 2)
          FileWrite ($file, StringReplace ($content, $values1[$i], "Machines" & $values6[0] & ".vbox"))
          FileClose ($file)
        EndIf
      Next

      For $j = 0 To UBound ($values3) - 1
        $values7 = _StringBetween ($values3[$j], 'HardDisks', '.vdi')
        If $values7 <> 0 Then
          $content = FileRead (FileOpen (@ScriptDir&"\data\.VirtualBox\VirtualBox.xml", 128))
          $file    = FileOpen (@ScriptDir&"\data\.VirtualBox\VirtualBox.xml", 2)
          FileWrite ($file, StringReplace ($content, $values3[$j], "HardDisks" & $values7[0] & ".vdi"))
          FileClose ($file)
        EndIf
      Next

      For $k = 0 To UBound ($values3) - 1
        $values8 = _StringBetween ($values3[$k], 'Machines', '.vdi')
        If $values8 <> 0 Then
          $content = FileRead (FileOpen (@ScriptDir&"\data\.VirtualBox\VirtualBox.xml", 128))
          $file    = FileOpen (@ScriptDir&"\data\.VirtualBox\VirtualBox.xml", 2)
          FileWrite ($file, StringReplace ($content, $values3[$k], "Machines" & $values8[0] & ".vdi"))
          FileClose ($file)
        EndIf
      Next

      For $l = 0 To UBound ($values5) - 1
        $values9 = _StringBetween ($values5[$l], 'location="', '"')
        If $values9 <> 0 Then
          If NOT FileExists ($values9[0]) Then
            $content = FileRead (FileOpen (@ScriptDir&"\data\.VirtualBox\VirtualBox.xml", 128))
            $file    = FileOpen (@ScriptDir&"\data\.VirtualBox\VirtualBox.xml", 2)
            FileWrite ($file, StringReplace ($content, "<Image" & $values5[$l] & "/>", ""))
            FileClose ($file)
          EndIf
        EndIf
      Next

      For $m = 0 To UBound ($values11) - 1
        $values12 = _StringBetween ($values11[$m], 'defaultMachineFolder="', '"')
        If $values12 <> 0 Then
          If NOT FileExists ($values10[0]) Then
            $content = FileRead (FileOpen (@ScriptDir&"\data\.VirtualBox\VirtualBox.xml", 128))
            $file    = FileOpen (@ScriptDir&"\data\.VirtualBox\VirtualBox.xml", 2)
            FileWrite ($file, StringReplace ($content, $values12[0], @ScriptDir&"\data\.VirtualBox\Machines"))
            FileClose ($file)
          EndIf
        EndIf
      Next

      For $n = 0 To UBound ($values1) - 1
        $values13 = _StringBetween ($values1[$n], 'Machines', '.xml')
        If $values13 <> 0 Then
          $content = FileRead (FileOpen (@ScriptDir&"\data\.VirtualBox\VirtualBox.xml", 128))
          $file    = FileOpen (@ScriptDir&"\data\.VirtualBox\VirtualBox.xml", 2)
          FileWrite ($file, StringReplace ($content, $values1[$n], "Machines" & $values13[0] & ".xml"))
          FileClose ($file)
        EndIf
      Next

      FileClose ($file)
    EndIf
  Else
    MsgBox (0, IniRead ($var2 & $lng &".ini", "download", "15", "NotFound"), IniRead ($var2 & $lng &".ini", "download", "16", "NotFound"))
EndIf


  If FileExists (@ScriptDir&"\"& $arch & "\VirtualBox.exe") AND FileExists (@ScriptDir&"\"& $arch & "\VBoxSVC.exe") AND FileExists (@ScriptDir&"\"& $arch & "\VBoxC.dll") Then
    If NOT ProcessExists ("VirtualBox.exe") OR NOT ProcessExists ("VBoxManage.exe") Then
      If FileExists (@ScriptDir&"\data\settings\SplashScreen.jpg") Then
        SplashImageOn ("Portable-VirtualBox", @ScriptDir&"\data\settings\SplashScreen.jpg", 480, 360, -1, -1, 1)
      Else
        SplashTextOn ("Portable-VirtualBox", IniRead ($var2 & $lng &".ini", "messages", "06", "NotFound"), 220, 40, -1, -1, 1, "arial", 12)
      EndIf

      If IniRead ($var1, "hotkeys", "key", "NotFound") = 1 Then
        HotKeySet (IniRead ($var1, "hotkeys", "01", "NotFound") & IniRead ($var1, "hotkeys", "07", "NotFound") & IniRead ($var1, "hotkeys", "13", "NotFound") & IniRead ($var1, "hotkeys", "19", "NotFound"), "ShowWindows_VM")
        HotKeySet (IniRead ($var1, "hotkeys", "02", "NotFound") & IniRead ($var1, "hotkeys", "08", "NotFound") & IniRead ($var1, "hotkeys", "14", "NotFound") & IniRead ($var1, "hotkeys", "20", "NotFound"), "HideWindows_VM")
        HotKeySet (IniRead ($var1, "hotkeys", "03", "NotFound") & IniRead ($var1, "hotkeys", "09", "NotFound") & IniRead ($var1, "hotkeys", "15", "NotFound") & IniRead ($var1, "hotkeys", "21", "NotFound"), "ShowWindows")
        HotKeySet (IniRead ($var1, "hotkeys", "04", "NotFound") & IniRead ($var1, "hotkeys", "10", "NotFound") & IniRead ($var1, "hotkeys", "16", "NotFound") & IniRead ($var1, "hotkeys", "22", "NotFound"), "HideWindows")
        HotKeySet (IniRead ($var1, "hotkeys", "05", "NotFound") & IniRead ($var1, "hotkeys", "11", "NotFound") & IniRead ($var1, "hotkeys", "17", "NotFound") & IniRead ($var1, "hotkeys", "23", "NotFound"), "Settings")
        HotKeySet (IniRead ($var1, "hotkeys", "06", "NotFound") & IniRead ($var1, "hotkeys", "12", "NotFound") & IniRead ($var1, "hotkeys", "18", "NotFound") & IniRead ($var1, "hotkeys", "24", "NotFound"), "ExitScript")

        Local $ctrl1, $ctrl2, $ctrl3, $ctrl4, $ctrl5, $ctrl6
        Local $alt1, $alt2, $alt3, $alt4, $alt5, $alt6
        Local $shift1, $shift2, $shift3, $shift4, $shift5, $shift6
        Local $plus01, $plus02, $plus03, $plus04, $plus05, $plus06, $plus07, $plus08, $plus09, $plus10, $plus11, $plus12, $plus13, $plus14, $plus15, $plus16, $plus17, $plus18

	If IniRead ($var1, "hotkeys", "01", "NotFound") = "^" Then
          $ctrl1  = "CTRL"
          $plus01 = "+"
        EndIf
        If IniRead ($var1, "hotkeys", "02", "NotFound") = "^" Then
          $ctrl2  = "CTRL"
          $plus02 = "+"
        EndIf
        If IniRead ($var1, "hotkeys", "03", "NotFound") = "^" Then
          $ctrl3  = "CTRL"
          $plus03 = "+"
        EndIf
        If IniRead ($var1, "hotkeys", "04", "NotFound") = "^" Then
          $ctrl4  = "CTRL"
          $plus04 = "+"
        EndIf
        If IniRead ($var1, "hotkeys", "05", "NotFound") = "^" Then
          $ctrl5  = "CTRL"
          $plus05 = "+"
        EndIf
        If IniRead ($var1, "hotkeys", "06", "NotFound") = "^" Then
          $ctrl6  = "CTRL"
          $plus06 = "+"
        EndIf

        If IniRead ($var1, "hotkeys", "07", "NotFound") = "!" Then
          $alt1   = "ALT"
          $plus07 = "+"
        EndIf
        If IniRead ($var1, "hotkeys", "08", "NotFound") = "!" Then
          $alt2   = "ALT"
          $plus08 = "+"
        EndIf
        If IniRead ($var1, "hotkeys", "09", "NotFound") = "!" Then
          $alt3   = "ALT"
          $plus09 = "+"
        EndIf
        If IniRead ($var1, "hotkeys", "10", "NotFound") = "!" Then
          $alt4   = "ALT"
          $plus10 = "+"
        EndIf
        If IniRead ($var1, "hotkeys", "11", "NotFound") = "!" Then
          $alt5   = "ALT"
          $plus11 = "+"
        EndIf
        If IniRead ($var1, "hotkeys", "12", "NotFound") = "!" Then
          $alt6   = "ALT"
          $plus12 = "+"
        EndIf

        If IniRead ($var1, "hotkeys", "13", "NotFound") = "+" Then
          $shift1 = "SHIFT"
          $plus13 = "+"
        EndIf
        If IniRead ($var1, "hotkeys", "14", "NotFound") = "+" Then
          $shift2 = "SHIFT"
          $plus14 = "+"
        EndIf
        If IniRead ($var1, "hotkeys", "15", "NotFound") = "+" Then
          $shift3 = "SHIFT"
          $plus15 = "+"
        EndIf
        If IniRead ($var1, "hotkeys", "16", "NotFound") = "+" Then
          $shift4 = "SHIFT"
          $plus16 = "+"
        EndIf
        If IniRead ($var1, "hotkeys", "17", "NotFound") = "+" Then
          $shift5 = "SHIFT"
          $plus17 = "+"
        EndIf
        If IniRead ($var1, "hotkeys", "18", "NotFound") = "+" Then
          $shift6 = "SHIFT"
          $plus18 = "+"
        EndIf

        TrayCreateItem (IniRead ($var2 & $lng &".ini", "tray", "01", "NotFound") &" (" & $ctrl1 & $plus01 & $alt1 & $plus07 & $shift1 & $plus13 & IniRead ($var1, "hotkeys", "19", "NotFound") & ")")
        TrayItemSetOnEvent (-1, "ShowWindows_VM")
        TrayCreateItem (IniRead ($var2 & $lng &".ini", "tray", "02", "NotFound") &" (" & $ctrl2 & $plus02 & $alt2 & $plus08 & $shift2 & $plus14 & IniRead ($var1, "hotkeys", "20", "NotFound") & ")")
        TrayItemSetOnEvent (-1, "HideWindows_VM")
        TrayCreateItem ("")
        TrayCreateItem (IniRead ($var2 & $lng &".ini", "tray", "03", "NotFound") &" (" & $ctrl3 & $plus03 & $alt3 & $plus09 & $shift3 & $plus15 & IniRead ($var1, "hotkeys", "21", "NotFound") & ")")
        TrayItemSetOnEvent (-1, "ShowWindows")
        TrayCreateItem (IniRead ($var2 & $lng &".ini", "tray", "04", "NotFound") &" (" & $ctrl4 & $plus04 & $alt4 & $plus10 & $shift4 & $plus16 & IniRead ($var1, "hotkeys", "22", "NotFound") & ")")
        TrayItemSetOnEvent (-1, "HideWindows")
        TrayCreateItem ("")
        TrayCreateItem (IniRead ($var2 & $lng &".ini", "tray", "05", "NotFound") &" (" & $ctrl5 & $plus05 & $alt5 & $plus11 & $shift5 & $plus17 & IniRead ($var1, "hotkeys", "23", "NotFound") & ")")
        TrayItemSetOnEvent (-1, "Settings")
        TrayCreateItem ("")
        TrayCreateItem (IniRead ($var2 & $lng &".ini", "tray", "06", "NotFound") &" (" & $ctrl6 & $plus06 & $alt6 & $plus12 & $shift6 & $plus18 & IniRead ($var1, "hotkeys", "24", "NotFound") & ")")
        TrayItemSetOnEvent (-1, "ExitScript")
        TraySetState ()
	TraySetToolTip (IniRead ($var2 & $lng &".ini", "tray", "07", "NotFound"))
	TrayTip("", IniRead ($var2 & $lng &".ini", "tray", "07", "NotFound"), 5)
      Else
        TrayCreateItem (IniRead ($var2 & $lng &".ini", "tray", "01", "NotFound"))
        TrayItemSetOnEvent (-1, "ShowWindows_VM")
        TrayCreateItem (IniRead ($var2 & $lng &".ini", "tray", "02", "NotFound"))
        TrayItemSetOnEvent (-1, "HideWindows_VM")
        TrayCreateItem ("")
        TrayCreateItem (IniRead ($var2 & $lng &".ini", "tray", "03", "NotFound"))
        TrayItemSetOnEvent (-1, "ShowWindows")
        TrayCreateItem (IniRead ($var2 & $lng &".ini", "tray", "04", "NotFound"))
        TrayItemSetOnEvent (-1, "HideWindows")
        TrayCreateItem ("")
        TrayCreateItem (IniRead ($var2 & $lng &".ini", "tray", "05", "NotFound"))
        TrayItemSetOnEvent (-1, "Settings")
        TrayCreateItem ("")
        TrayCreateItem (IniRead ($var2 & $lng &".ini", "tray", "06", "NotFound"))
        TrayItemSetOnEvent (-1, "ExitScript")
        TraySetState ()
	TraySetToolTip (IniRead ($var2 & $lng &".ini", "tray", "07", "NotFound"))
	TrayTip("", IniRead ($var2 & $lng &".ini", "tray", "07", "NotFound"), 5)
      EndIf

      If @OSArch = "x86" Then
        If NOT FileExists (@SystemDir&"\msvcp71.dll") OR NOT FileExists (@SystemDir&"\msvcr71.dll") OR NOT FileExists (@SystemDir&"\msvcrt.dll") Then
          FileCopy (@ScriptDir&"\app32\msvcp71.dll", @SystemDir, 9)
          FileCopy (@ScriptDir&"\app32\msvcr71.dll", @SystemDir, 9)
          FileCopy (@ScriptDir&"\app32\msvcrt.dll", @SystemDir, 9)
          Local $msv = 1
        Else
          Local $msv = 0
        EndIf
      EndIf

      If @OSArch = "x64" Then
        If NOT FileExists (@SystemDir&"\msvcp80.dll") OR NOT FileExists (@SystemDir&"\msvcr80.dll") Then
          FileCopy (@ScriptDir&"\app64\msvcp80.dll", @SystemDir, 9)
          FileCopy (@ScriptDir&"\app64\msvcr80.dll", @SystemDir, 9)
          Local $msv = 2
        Else
          Local $msv = 0
        EndIf
      EndIf

      If FileExists (@ScriptDir&"\"& $arch &"\") AND FileExists (@ScriptDir&"\vboxadditions\") Then
        DirMove (@ScriptDir&"\vboxadditions\doc", @ScriptDir&"\"& $arch, 1)
        DirMove (@ScriptDir&"\vboxadditions\ExtensionPacks", @ScriptDir&"\"& $arch, 1)
        DirMove (@ScriptDir&"\vboxadditions\nls", @ScriptDir&"\"& $arch, 1)
        FileMove (@ScriptDir&"\vboxadditions\guestadditions\*.*", @ScriptDir&"\"& $arch &"\", 9)
      Endif

      RunWait ($arch&"\VBoxSVC.exe /reregserver", @ScriptDir, @SW_HIDE)
      RunWait (@SystemDir&"\regsvr32.exe /S "& $arch &"\VBoxC.dll", @ScriptDir, @SW_HIDE)
      DllCall ($arch&"\VBoxRT.dll", "hwnd", "RTR3Init")

      SplashOff ()

      If RegRead ("HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\VBoxDRV", "DisplayName") <> "VirtualBox Service" Then
        RunWait ("cmd /c sc create VBoxDRV binpath= ""%CD%\"& $arch &"\drivers\VBoxDrv\VBoxDrv.sys"" type= kernel start= auto error= normal displayname= PortableVBoxDRV", @ScriptDir, @SW_HIDE)
        Local $DRV = 1
      Else
        Local $DRV = 0
      EndIf

      If IniRead ($var1, "usb", "key", "NotFound") = 1 Then
        If RegRead ("HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\VBoxUSB", "DisplayName") <> "VirtualBox USB" Then
          If @OSArch = "x86" Then
            RunWait (@ScriptDir &"\data\tools\devcon_x86.exe install .\"& $arch &"\drivers\USB\device\VBoxUSB.inf ""USB\VID_80EE&PID_CAFE""", @ScriptDir, @SW_HIDE)
          EndIf
          If @OSArch = "x64" Then
            RunWait (@ScriptDir &"\data\tools\devcon_x64.exe install .\"& $arch &"\drivers\USB\device\VBoxUSB.inf ""USB\VID_80EE&PID_CAFE""", @ScriptDir, @SW_HIDE)
          EndIf
          FileCopy (@ScriptDir&"\"& $arch &"\drivers\USB\device\VBoxUSB.sys", @SystemDir&"\drivers", 9)
          Local $USB = 1
        Else
          Local $USB = 0
        EndIf
      Else
        Local $USB = 0
      EndIf

      If RegRead ("HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\VBoxUSBMon", "DisplayName") <> "VirtualBox USB Monitor Driver" Then
        RunWait ("cmd /c sc create VBoxUSBMon binpath= ""%CD%\"& $arch &"\drivers\USB\filter\VBoxUSBMon.sys"" type= kernel start= auto error= normal displayname= PortableVBoxUSBMon", @ScriptDir, @SW_HIDE)
        Local $MON = 1
      Else
        Local $MON = 0
      EndIf

      If IniRead ($var1, "net", "key", "NotFound") = 1 Then
        If RegRead ("HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\VBoxNetAdp", "DisplayName") <> "VirtualBox Host-Only Network Adapter" Then
          If @OSArch = "x86" Then
            RunWait (@ScriptDir &"\data\tools\devcon_x86.exe install .\"& $arch &"\drivers\network\netadp\VBoxNetAdp.inf ""sun_VBoxNetAdp""", @ScriptDir, @SW_HIDE)
          EndIf
          If @OSArch = "x64" Then
            RunWait (@ScriptDir &"\data\tools\devcon_x64.exe install .\"& $arch &"\drivers\network\netadp\VBoxNetAdp.inf ""sun_VBoxNetAdp""", @ScriptDir, @SW_HIDE)
          EndIf
          FileCopy (@ScriptDir&"\"& $arch &"\drivers\network\netadp\VBoxNetAdp.sys", @SystemDir&"\drivers", 9)
          Local $ADP = 1
        Else
          Local $ADP = 0
        EndIf
      Else
        Local $ADP = 0
      EndIf

      If IniRead ($var1, "net", "key", "NotFound") = 1 Then
        If RegRead ("HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\VBoxNetFlt", "DisplayName") <> "VBoxNetFlt Service" Then
          If @OSArch = "x86" Then
            RunWait (@ScriptDir&"\data\tools\snetcfg_x86.exe -v -u sun_VBoxNetFlt", @ScriptDir, @SW_HIDE)
            RunWait (@ScriptDir&"\data\tools\snetcfg_x86.exe -v -l .\"& $arch &"\drivers\network\netflt\VBoxNetFlt.inf -m .\"& $arch &"\drivers\network\netflt\VBoxNetFltM.inf -c s -i sun_VBoxNetFlt", @ScriptDir, @SW_HIDE)
          EndIf
          If @OSArch = "x64" Then
            RunWait (@ScriptDir&"\data\tools\snetcfg_x64.exe -v -u sun_VBoxNetFlt", @ScriptDir, @SW_HIDE)
            RunWait (@ScriptDir&"\data\tools\snetcfg_x64.exe -v -l .\"& $arch &"\drivers\network\netflt\VBoxNetFlt.inf -m .\"& $arch &"\drivers\network\netflt\VBoxNetFltM.inf -c s -i sun_VBoxNetFlt", @ScriptDir, @SW_HIDE)
          EndIf
          FileCopy (@ScriptDir&"\"& $arch &"\drivers\network\netflt\VBoxNetFltNobj.dll", @SystemDir, 9)
          FileCopy (@ScriptDir&"\"& $arch &"\drivers\network\netflt\VBoxNetFlt.sys", @SystemDir&"\drivers", 9)
          RunWait (@SystemDir&"\regsvr32.exe /S "& @SystemDir &"\VBoxNetFltNobj.dll", @ScriptDir, @SW_HIDE)
          Local $NET = 1
        Else
          Local $NET = 0
        EndIf
      Else
        Local $NET = 0
      EndIf

      If $DRV = 1 Then
        RunWait ("sc start VBoxDRV", @ScriptDir, @SW_HIDE)
      EndIf

      If $USB = 1 Then
        RunWait ("sc start VBoxUSB", @ScriptDir, @SW_HIDE)
      EndIf

      If $MON = 1 Then
        RunWait ("sc start VBoxUSBMon", @ScriptDir, @SW_HIDE)
      EndIf

      If $ADP = 1 Then
        RunWait ("sc start VBoxNetAdp", @ScriptDir, @SW_HIDE)
      EndIf

      If $NET = 1 Then
        RunWait ("sc start VBoxNetFlt", @ScriptDir, @SW_HIDE)
      EndIf

      If $CmdLine[0] = 1 Then
        If FileExists (@ScriptDir&"\data\.VirtualBox") Then
          Local $UserHome = IniRead ($var1, "userhome", "key", "NotFound")
          Local $StartVM  = $CmdLine[1]
          If IniRead ($var1, "userhome", "key", "NotFound") = "%CD%\data\.VirtualBox" AND FileExists (@ScriptDir&"\data\.VirtualBox\HardDisks\"&$CmdLine[1]&".vdi") Then
            RunWait ("cmd /c set VBOX_USER_HOME="& $UserHome &"& .\"& $arch &"\VBoxManage.exe startvm """& $StartVM &"""" , @ScriptDir, @SW_HIDE)
          Else
            RunWait ("cmd /c set VBOX_USER_HOME="& $UserHome &"& .\"& $arch &"\VirtualBox.exe", @ScriptDir, @SW_HIDE)
          EndIf
        Else
          RunWait ("cmd /c set VBOX_USER_HOME=%CD%\data\.VirtualBox & .\"& $arch &"\VirtualBox.exe", @ScriptDir, @SW_HIDE)
        EndIf

        ProcessWaitClose ("VirtualBox.exe")
        ProcessWaitClose ("VBoxManage.exe")
      Else
        If FileExists (@ScriptDir&"\data\.VirtualBox") Then
          Local $UserHome = IniRead ($var1, "userhome", "key", "NotFound")
          Local $StartVM  = IniRead ($var1, "startvm", "key", "NotFound")
          If IniRead ($var1, "startvm", "key", "NotFound") = true Then
            RunWait ("cmd /C set VBOX_USER_HOME="& $UserHome &"& .\"& $arch &"\VBoxManage.exe startvm """& $StartVM &"""" , @ScriptDir, @SW_HIDE)
          Else
            RunWait ("cmd /c set VBOX_USER_HOME="& $UserHome &"& .\"& $arch &"\VirtualBox.exe", @ScriptDir, @SW_HIDE)
          EndIf
        Else
          RunWait ("cmd /c set VBOX_USER_HOME=%CD%\data\.VirtualBox & .\"& $arch &"\VirtualBox.exe", @ScriptDir, @SW_HIDE)
        EndIf

        ProcessWaitClose ("VirtualBox.exe")
        ProcessWaitClose ("VBoxManage.exe")
      EndIf

      SplashTextOn ("Portable-VirtualBox", IniRead ($var2 & $lng &".ini", "messages", "07", "NotFound"), 220, 40, -1, -1, 1, "arial", 12)

      ProcessWaitClose ("VBoxSVC.exe")

      EnvSet ("VBOX_USER_HOME")
      Local $timer=0

      Local $PID = ProcessExists ("VBoxSVC.exe")
      If $PID Then ProcessClose ($PID)

      While $timer < 10000 AND $PID
	$PID = ProcessExists ("VBoxSVC.exe")
	If $PID Then ProcessClose ($PID)
	Sleep(1000)
	$timer += 1000
      Wend

      RunWait ($arch&"\VBoxSVC.exe /unregserver", @ScriptDir, @SW_HIDE)
      RunWait (@SystemDir&"\regsvr32.exe /S /U "& $arch &"\VBoxC.dll", @ScriptDir, @SW_HIDE)

      If $DRV = 1 Then
        RunWait ("sc stop VBoxDRV", @ScriptDir, @SW_HIDE)
      EndIf

      If $USB = 1 Then
        RunWait ("sc stop VBoxUSB", @ScriptDir, @SW_HIDE)
        If @OSArch = "x86" Then
          RunWait (@ScriptDir &"\data\tools\devcon_x86.exe remove ""USB\VID_80EE&PID_CAFE""", @ScriptDir, @SW_HIDE)
        EndIf
        If @OSArch = "x64" Then
          RunWait (@ScriptDir &"\data\tools\devcon_x64.exe remove ""USB\VID_80EE&PID_CAFE""", @ScriptDir, @SW_HIDE)
        EndIf
        FileDelete (@SystemDir&"\drivers\VBoxUSB.sys")
      EndIf

      If $MON = 1 Then
        RunWait ("sc stop VBoxUSBMon", @ScriptDir, @SW_HIDE)
      EndIf

      If $ADP = 1 Then
        RunWait ("sc stop VBoxNetAdp", @ScriptDir, @SW_HIDE)
        If @OSArch = "x86" Then
          RunWait (@ScriptDir &"\data\tools\devcon_x86.exe remove ""sun_VBoxNetAdp""", @ScriptDir, @SW_HIDE)
        EndIf
        If @OSArch = "x64" Then
          RunWait (@ScriptDir &"\data\tools\devcon_x64.exe remove ""sun_VBoxNetAdp""", @ScriptDir, @SW_HIDE)
        EndIf
        FileDelete (@SystemDir&"\drivers\VBoxNetAdp.sys")
      EndIf

      If $NET = 1 Then
        RunWait ("sc stop VBoxNetFlt", @ScriptDir, @SW_HIDE)
        If @OSArch = "x86" Then
          RunWait (@ScriptDir&"\data\tools\snetcfg_x86.exe -v -u sun_VBoxNetFlt", @ScriptDir, @SW_HIDE)
        EndIf
        If @OSArch = "x64" Then
          RunWait (@ScriptDir&"\data\tools\snetcfg_x64.exe -v -u sun_VBoxNetFlt", @ScriptDir, @SW_HIDE)
        EndIf
        RunWait (@SystemDir&"\regsvr32.exe /S /U "&@SystemDir&"\VBoxNetFltNobj.dll", @ScriptDir, @SW_HIDE)
        RunWait ("sc delete VBoxNetFlt", @ScriptDir, @SW_HIDE)
        FileDelete (@SystemDir&"\VBoxNetFltNobj.dll")
        FileDelete (@SystemDir&"\drivers\VBoxNetFlt.sys")
      EndIf

      If FileExists (@ScriptDir&"\"& $arch &"\") AND FileExists (@ScriptDir&"\vboxadditions\") Then
        DirMove (@ScriptDir&"\"& $arch &"\doc", @ScriptDir&"\vboxadditions\", 1)
        DirMove (@ScriptDir&"\"& $arch &"\ExtensionPacks", @ScriptDir&"\vboxadditions\", 1)
        DirMove (@ScriptDir&"\"& $arch &"\nls", @ScriptDir&"\vboxadditions\", 1)
        FileMove (@ScriptDir&"\"& $arch &"\*.iso", @ScriptDir&"\vboxadditions\guestadditions\", 9)
      EndIf

      If $msv = 1 Then
        FileDelete (@SystemDir&"\msvcp71.dll")
        FileDelete (@SystemDir&"\msvcr71.dll")
        FileDelete (@SystemDir&"\msvcrt.dll")
      EndIf

      If $msv = 2 Then
        FileDelete (@SystemDir&"\msvcp80.dll")
        FileDelete (@SystemDir&"\msvcr80.dll")
      EndIf

      If $DRV = 1 Then
        RunWait ("sc delete VBoxDRV", @ScriptDir, @SW_HIDE)
      EndIf

      If $USB = 1 Then
        RunWait ("sc delete VBoxUSB", @ScriptDir, @SW_HIDE)
      EndIf

      If $MON = 1 Then
        RunWait ("sc delete VBoxUSBMon", @ScriptDir, @SW_HIDE)
      EndIf

      If $ADP = 1 Then
        RunWait ("sc delete VBoxNetAdp", @ScriptDir, @SW_HIDE)
      EndIf

      If $NET = 1 Then
        RunWait ("sc delete VBoxNetFlt", @ScriptDir, @SW_HIDE)
      EndIf

      SplashOff ()
    Else
      WinSetState ("Oracle VM VirtualBox Manager", "", BitAND (@SW_SHOW, @SW_RESTORE))
      WinSetState ("] - Oracle VM VirtualBox", "", BitAND (@SW_SHOW, @SW_RESTORE))
    EndIf
  Else
    SplashOff ()
    MsgBox (0, IniRead ($var2 & $lng &".ini", "messages", "01", "NotFound"), IniRead ($var2 & $lng &".ini", "start", "01", "NotFound"))
  EndIf
EndIf

Break (1)
Exit

Func ShowWindows_VM ()
  Opt ("WinTitleMatchMode", 2)
  WinSetState ("] - Oracle VM VirtualBox", "", BitAND (@SW_SHOW, @SW_RESTORE))
EndFunc

Func HideWindows_VM ()
  Opt ("WinTitleMatchMode", 2)
  WinSetState ("] - Oracle VM VirtualBox", "", @SW_HIDE)
EndFunc

Func ShowWindows ()
  Opt ("WinTitleMatchMode", 3)
  WinSetState ("Oracle VM VirtualBox Manager", "", BitAND (@SW_SHOW, @SW_RESTORE))
EndFunc

Func HideWindows ()
  Opt ("WinTitleMatchMode", 3)
  WinSetState ("Oracle VM VirtualBox Manager", "", @SW_HIDE)
EndFunc

Func Settings ()
  Opt ("GUIOnEventMode", 1)

  Global $Radio1, $Radio2, $Radio3, $Radio4, $Radio5, $Radio6, $Radio7, $Radio8, $Radio9, $Radio10, $Radio11, $Radio12, $Radio13, $Radio14
  Global $Checkbox01, $Checkbox02, $Checkbox03, $Checkbox04, $Checkbox05, $Checkbox06, $Checkbox07, $Checkbox08, $Checkbox09
  Global $Checkbox10, $Checkbox11, $Checkbox12, $Checkbox13, $Checkbox14, $Checkbox15, $Checkbox16, $Checkbox17, $Checkbox18
  Global $Input1, $Input2, $Input3, $Input4, $Input5, $Input6
  Global $HomeRoot, $VMStart, $StartLng

  Local $WS_POPUP

  GUICreate (IniRead ($var2 & $lng &".ini", "settings-label", "01", "NotFound"), 580, 318, 193, 125, $WS_POPUP)
  GUISetFont (9, 400, 0, "Arial")
  GUISetBkColor (0xFFFFFF)
  GUICtrlSetFont (-1, 10, 800, 0, "Arial")
  GUICtrlCreateTab (0, 0, 577, 296)

  GUICtrlCreateTabItem (IniRead ($var2 & $lng &".ini", "homeroot-settings", "01", "NotFound"))
    GUICtrlCreateLabel (IniRead ($var2 & $lng &".ini", "homeroot-settings", "02", "NotFound"), 16, 40, 546, 105)

    $Radio1 = GUICtrlCreateRadio ("Radio01", 20, 153, 17, 17)
    If IniRead ($var1, "userhome", "key", "NotFound") = "%CD%\data\.VirtualBox" Then
      GUICtrlSetState (-1, $GUI_CHECKED)
    EndIf

    $Radio2 = GUICtrlCreateRadio ("Radio02", 20, 185, 17, 17)
    If IniRead ($var1, "userhome", "key", "NotFound") <> "%CD%\data\.VirtualBox" Then
      GUICtrlSetState (-1, $GUI_CHECKED)
    EndIf

    GUICtrlCreateLabel (IniRead ($var2 & $lng &".ini", "homeroot-settings", "03", "NotFound"), 36, 153, 524, 21)
    GUICtrlCreateLabel (IniRead ($var2 & $lng &".ini", "homeroot-settings", "04", "NotFound"), 36, 185, 180, 21)

    If IniRead ($var1, "userhome", "key", "NotFound") = "%CD%\data\.VirtualBox" Then
      $HomeRoot = GUICtrlCreateInput (IniRead ($var2 & $lng &".ini", "homeroot-settings", "05", "NotFound"), 220, 185, 249, 21)
    Else
      $User_Home = IniRead ($var1, "userhome", "key", "NotFound")
      $HomeRoot  = GUICtrlCreateInput ($User_Home, 220, 185, 249, 21)
    EndIf

    GUICtrlCreateButton (IniRead ($var2 & $lng &".ini", "homeroot-settings", "06", "NotFound"), 476, 185, 81, 21, 0)
    GUICtrlSetOnEvent (-1, "SRCUserHome")
    GUICtrlCreateButton (IniRead ($var2 & $lng &".ini", "messages", "02", "NotFound"), 112, 240, 129, 25, 0)
    GUICtrlSetOnEvent (-1, "OKUserHome")
    GUICtrlCreateButton (IniRead ($var2 & $lng &".ini", "messages", "03", "NotFound"), 336, 240, 129, 25, 0)
    GUICtrlSetOnEvent (-1, "ExitGUI")

  GUICtrlCreateTabItem (IniRead ($var2 & $lng &".ini", "startvm-settings", "01", "NotFound"))
    GUICtrlCreateLabel (IniRead ($var2 & $lng &".ini", "startvm-settings", "02", "NotFound"), 16, 40, 546, 105)

    $Radio3 = GUICtrlCreateRadio ("Radio3", 20, 153, 17, 17)
    If IniRead ($var1, "startvm", "key", "NotFound") = false Then
      GUICtrlSetState (-1, $GUI_CHECKED)
    EndIf

    $Radio4 = GUICtrlCreateRadio ("Radio4", 20, 185, 17, 17)
    If IniRead ($var1, "startvm", "key", "NotFound") = true Then
      GUICtrlSetState (-1, $GUI_CHECKED)
    EndIf

    GUICtrlCreateLabel (IniRead ($var2 & $lng &".ini", "startvm-settings", "03", "NotFound"), 36, 153, 524, 21)
    GUICtrlCreateLabel (IniRead ($var2 & $lng &".ini", "startvm-settings", "04", "NotFound"), 36, 185, 180, 21)

    If IniRead ($var1, "startvm", "key", "NotFound") = false Then
      $VMStart = GUICtrlCreateInput (IniRead ($var2 & $lng &".ini", "startvm-settings", "05", "NotFound"), 220, 185, 249, 21)
    Else
      $Start_VM = IniRead ($var1, "startvm", "key", "NotFound")
      $VMStart  = GUICtrlCreateInput ($Start_VM, 220, 185, 249, 21)
    EndIf

    GUICtrlCreateButton (IniRead ($var2 & $lng &".ini", "startvm-settings", "06", "NotFound"), 476, 185, 81, 21, 0)
    GUICtrlSetOnEvent (-1, "SRCStartVM")
    GUICtrlCreateButton (IniRead ($var2 & $lng &".ini", "messages", "02", "NotFound"), 112, 240, 129, 25, 0)
    GUICtrlSetOnEvent (-1, "OKStartVM")
    GUICtrlCreateButton (IniRead ($var2 & $lng &".ini", "messages", "03", "NotFound"), 336, 240, 129, 25, 0)
    GUICtrlSetOnEvent (-1, "ExitGUI")

  GUICtrlCreateTabItem (IniRead ($var2 & $lng &".ini", "hotkeys", "01", "NotFound"))
    GUICtrlCreateLabel (IniRead ($var2 & $lng &".ini", "hotkeys", "02", "NotFound"), 16, 40, 546, 105)

    $Radio5 = GUICtrlCreateRadio ("Radio5", 20, 153, 17, 17)
    If IniRead ($var1, "hotkeys", "key", "NotFound") = 1 Then
      GUICtrlSetState (-1, $GUI_CHECKED)
    EndIf

    $Radio6 = GUICtrlCreateRadio ("Radio6", 20, 185, 17, 17)
    If IniRead ($var1, "hotkeys", "key", "NotFound") = 0 Then
      GUICtrlSetState (-1, $GUI_CHECKED)
    EndIf

    GUICtrlCreateLabel (IniRead ($var2 & $lng &".ini", "hotkeys", "03", "NotFound"), 36, 153, 524, 21)
    GUICtrlCreateLabel (IniRead ($var2 & $lng &".ini", "hotkeys", "04", "NotFound"), 36, 185, 524, 21)

    GUICtrlCreateButton (IniRead ($var2 & $lng &".ini", "messages", "02", "NotFound"), 112, 240, 129, 25, 0)
    GUICtrlSetOnEvent (-1, "OKHotKeys")
    GUICtrlCreateButton (IniRead ($var2 & $lng &".ini", "messages", "03", "NotFound"), 336, 240, 129, 25, 0)
    GUICtrlSetOnEvent (-1, "ExitGUI")

  GUICtrlCreateTabItem (IniRead ($var2 & $lng &".ini", "hotkey-settings", "01", "NotFound"))
    GUICtrlCreateLabel (IniRead ($var2 & $lng &".ini", "hotkey-settings", "02", "NotFound"), 16, 40, 546, 60)

    $Radio7 = GUICtrlCreateRadio ("Radio7", 20, 112, 17, 17)
    If IniRead ($var1, "hotkeys", "userkey", "NotFound") = 0 Then
      GUICtrlSetState (-1, $GUI_CHECKED)
    EndIf

    $Radio8 = GUICtrlCreateRadio ("Radio8", 154, 112, 17, 17)
    If IniRead ($var1, "hotkeys", "userkey", "NotFound") = 1 Then
      GUICtrlSetState (-1, $GUI_CHECKED)
    EndIf

    GUICtrlCreateLabel (IniRead ($var2 & $lng &".ini", "hotkey-settings", "03", "NotFound"), 38, 113, 100, 122)

    GUICtrlCreateLabel (IniRead ($var2 & $lng &".ini", "tray", "01", "NotFound") &":", 172, 113, 120, 17)
    GUICtrlCreateLabel (IniRead ($var2 & $lng &".ini", "tray", "02", "NotFound") &":", 172, 133, 120, 17)
    GUICtrlCreateLabel (IniRead ($var2 & $lng &".ini", "tray", "03", "NotFound") &":", 172, 153, 120, 17)
    GUICtrlCreateLabel (IniRead ($var2 & $lng &".ini", "tray", "04", "NotFound") &":", 172, 173, 120, 17)
    GUICtrlCreateLabel (IniRead ($var2 & $lng &".ini", "tray", "05", "NotFound") &":", 172, 193, 120, 17)
    GUICtrlCreateLabel (IniRead ($var2 & $lng &".ini", "tray", "06", "NotFound") &":", 172, 213, 120, 17)

    GUICtrlCreateLabel ("CTRL +", 318, 113, 44, 17)
    GUICtrlCreateLabel ("CTRL +", 318, 133, 44, 17)
    GUICtrlCreateLabel ("CTRL +", 318, 153, 44, 17)
    GUICtrlCreateLabel ("CTRL +", 318, 173, 44, 17)
    GUICtrlCreateLabel ("CTRL +", 318, 193, 44, 17)
    GUICtrlCreateLabel ("CTRL +", 318, 213, 44, 17)

    GUICtrlCreateLabel ("ALT +", 395, 113, 44, 17)
    GUICtrlCreateLabel ("ALT +", 395, 133, 44, 17)
    GUICtrlCreateLabel ("ALT +", 395, 153, 44, 17)
    GUICtrlCreateLabel ("ALT +", 395, 173, 44, 17)
    GUICtrlCreateLabel ("ALT +", 395, 193, 44, 17)
    GUICtrlCreateLabel ("ALT +", 395, 213, 44, 17)

    GUICtrlCreateLabel ("SHIFT +", 460, 113, 44, 17)
    GUICtrlCreateLabel ("SHIFT +", 460, 133, 44, 17)
    GUICtrlCreateLabel ("SHIFT +", 460, 153, 44, 17)
    GUICtrlCreateLabel ("SHIFT +", 460, 173, 44, 17)
    GUICtrlCreateLabel ("SHIFT +", 460, 193, 44, 17)
    GUICtrlCreateLabel ("SHIFT +", 460, 213, 44, 17)

    $Checkbox01 = GUICtrlCreateCheckbox ("Checkbox01", 302, 112, 17, 17)
    If IniRead ($var1, "hotkeys", "01", "NotFound") = "^" Then
      GUICtrlSetState (-1, $GUI_CHECKED)
    EndIf
    $Checkbox02 = GUICtrlCreateCheckbox ("Checkbox02", 302, 132, 17, 17)
    If IniRead ($var1, "hotkeys", "02", "NotFound") = "^" Then
      GUICtrlSetState (-1, $GUI_CHECKED)
    EndIf
    $Checkbox03 = GUICtrlCreateCheckbox ("Checkbox03", 302, 152, 17, 17)
    If IniRead ($var1, "hotkeys", "03", "NotFound") = "^" Then
      GUICtrlSetState (-1, $GUI_CHECKED)
    EndIf
    $Checkbox04 = GUICtrlCreateCheckbox ("Checkbox04", 302, 172, 17, 17)
    If IniRead ($var1, "hotkeys", "04", "NotFound") = "^" Then
      GUICtrlSetState (-1, $GUI_CHECKED)
    EndIf
    $Checkbox05 = GUICtrlCreateCheckbox ("Checkbox05", 302, 192, 17, 17)
    If IniRead ($var1, "hotkeys", "05", "NotFound") = "^" Then
      GUICtrlSetState (-1, $GUI_CHECKED)
    EndIf
    $Checkbox06 = GUICtrlCreateCheckbox ("Checkbox06", 302, 212, 17, 17)
    If IniRead ($var1, "hotkeys", "06", "NotFound") = "^" Then
      GUICtrlSetState (-1, $GUI_CHECKED)
    EndIf

    $Checkbox07 = GUICtrlCreateCheckbox ("Checkbox07", 378, 112, 17, 17)
    If IniRead ($var1, "hotkeys", "07", "NotFound") = "!" Then
      GUICtrlSetState (-1, $GUI_CHECKED)
    EndIf
    $Checkbox08 = GUICtrlCreateCheckbox ("Checkbox08", 378, 132, 17, 17)
    If IniRead ($var1, "hotkeys", "08", "NotFound") = "!" Then
      GUICtrlSetState (-1, $GUI_CHECKED)
    EndIf
    $Checkbox09 = GUICtrlCreateCheckbox ("Checkbox09", 378, 152, 17, 17)
    If IniRead ($var1, "hotkeys", "09", "NotFound") = "!" Then
      GUICtrlSetState (-1, $GUI_CHECKED)
    EndIf
    $Checkbox10 = GUICtrlCreateCheckbox ("Checkbox10", 378, 172, 17, 17)
    If IniRead ($var1, "hotkeys", "10", "NotFound") = "!" Then
      GUICtrlSetState (-1, $GUI_CHECKED)
    EndIf
    $Checkbox11 = GUICtrlCreateCheckbox ("Checkbox11", 378, 192, 17, 17)
    If IniRead ($var1, "hotkeys", "11", "NotFound") = "!" Then
      GUICtrlSetState (-1, $GUI_CHECKED)
    EndIf
    $Checkbox12 = GUICtrlCreateCheckbox ("Checkbox12", 378, 212, 17, 17)
    If IniRead ($var1, "hotkeys", "12", "NotFound") = "!" Then
      GUICtrlSetState (-1, $GUI_CHECKED)
    EndIf

    $Checkbox13 = GUICtrlCreateCheckbox ("Checkbox13", 444, 112, 17, 17)
    If IniRead ($var1, "hotkeys", "13", "NotFound") = "+" Then
      GUICtrlSetState (-1, $GUI_CHECKED)
    EndIf
    $Checkbox14 = GUICtrlCreateCheckbox ("Checkbox14", 444, 132, 17, 17)
    If IniRead ($var1, "hotkeys", "14", "NotFound") = "+" Then
      GUICtrlSetState (-1, $GUI_CHECKED)
    EndIf
    $Checkbox15 = GUICtrlCreateCheckbox ("Checkbox15", 444, 152, 17, 17)
    If IniRead ($var1, "hotkeys", "15", "NotFound") = "+" Then
      GUICtrlSetState (-1, $GUI_CHECKED)
    EndIf
    $Checkbox16 = GUICtrlCreateCheckbox ("Checkbox16", 444, 172, 17, 17)
    If IniRead ($var1, "hotkeys", "16", "NotFound") = "+" Then
      GUICtrlSetState (-1, $GUI_CHECKED)
    EndIf
    $Checkbox17 = GUICtrlCreateCheckbox ("Checkbox17", 444, 192, 17, 17)
    If IniRead ($var1, "hotkeys", "17", "NotFound") = "+" Then
      GUICtrlSetState (-1, $GUI_CHECKED)
    EndIf
    $Checkbox18 = GUICtrlCreateCheckbox ("Checkbox18", 444, 212, 17, 17)
    If IniRead ($var1, "hotkeys", "18", "NotFound") = "+" Then
      GUICtrlSetState (-1, $GUI_CHECKED)
    EndIf

    $Input1 = GUICtrlCreateInput (IniRead ($var1, "hotkeys", "19", "NotFound"), 524, 111, 24, 21)
    $Input2 = GUICtrlCreateInput (IniRead ($var1, "hotkeys", "20", "NotFound"), 524, 131, 24, 21)
    $Input3 = GUICtrlCreateInput (IniRead ($var1, "hotkeys", "21", "NotFound"), 524, 151, 24, 21)
    $Input4 = GUICtrlCreateInput (IniRead ($var1, "hotkeys", "22", "NotFound"), 524, 171, 24, 21)
    $Input5 = GUICtrlCreateInput (IniRead ($var1, "hotkeys", "23", "NotFound"), 524, 191, 24, 21)
    $Input6 = GUICtrlCreateInput (IniRead ($var1, "hotkeys", "24", "NotFound"), 524, 211, 24, 21)

    GUICtrlCreateButton (IniRead ($var2 & $lng &".ini", "messages", "02", "NotFound"), 112, 240, 129, 25, 0)
    GUICtrlSetOnEvent (-1, "OKHotKeysSet")
    GUICtrlCreateButton (IniRead ($var2 & $lng &".ini", "messages", "03", "NotFound"), 336, 240, 129, 25, 0)
    GUICtrlSetOnEvent (-1, "ExitGUI")

  GUICtrlCreateTabItem (IniRead ($var2 & $lng &".ini", "usb", "01", "NotFound"))
    GUICtrlCreateLabel (IniRead ($var2 & $lng &".ini", "usb", "02", "NotFound"), 16, 40, 546, 105)

    $Radio9 = GUICtrlCreateRadio ("$Radio9", 20, 153, 17, 17)
    If IniRead ($var1, "usb", "key", "NotFound") = 0 Then
      GUICtrlSetState (-1, $GUI_CHECKED)
    EndIf

    $Radio10 = GUICtrlCreateRadio ("$Radio10", 20, 185, 17, 17)
    If IniRead ($var1, "usb", "key", "NotFound") = 1 Then
      GUICtrlSetState (-1, $GUI_CHECKED)
    EndIf

    GUICtrlCreateLabel (IniRead ($var2 & $lng &".ini", "usb", "03", "NotFound"), 40, 153, 524, 21)
    GUICtrlCreateLabel (IniRead ($var2 & $lng &".ini", "usb", "04", "NotFound"), 40, 185, 524, 21)

    GUICtrlCreateButton (IniRead ($var2 & $lng &".ini", "messages", "02", "NotFound"), 112, 240, 129, 25, 0)
    GUICtrlSetOnEvent (-1, "OKUSB")
    GUICtrlCreateButton (IniRead ($var2 & $lng &".ini", "messages", "03", "NotFound"), 336, 240, 129, 25, 0)
    GUICtrlSetOnEvent (-1, "ExitGUI")

  GUICtrlCreateTabItem (IniRead ($var2 & $lng &".ini", "net", "01", "NotFound"))
    GUICtrlCreateLabel (IniRead ($var2 & $lng &".ini", "net", "02", "NotFound"), 16, 40, 546, 105)

    $Radio11 = GUICtrlCreateRadio ("$Radio11", 20, 153, 17, 17)
    If IniRead ($var1, "net", "key", "NotFound") = 0 Then
      GUICtrlSetState (-1, $GUI_CHECKED)
    EndIf

    $Radio12 = GUICtrlCreateRadio ("$Radio12", 20, 185, 17, 17)
    If IniRead ($var1, "net", "key", "NotFound") = 1 Then
      GUICtrlSetState (-1, $GUI_CHECKED)
    EndIf

    GUICtrlCreateLabel (IniRead ($var2 & $lng &".ini", "net", "03", "NotFound"), 40, 153, 524, 21)
    GUICtrlCreateLabel (IniRead ($var2 & $lng &".ini", "net", "04", "NotFound"), 40, 185, 524, 21)

    GUICtrlCreateButton (IniRead ($var2 & $lng &".ini", "messages", "02", "NotFound"), 112, 240, 129, 25, 0)
    GUICtrlSetOnEvent (-1, "OKNet")
    GUICtrlCreateButton (IniRead ($var2 & $lng &".ini", "messages", "03", "NotFound"), 336, 240, 129, 25, 0)
    GUICtrlSetOnEvent (-1, "ExitGUI")

  GUICtrlCreateTabItem (IniRead ($var2 & $lng &".ini", "language-settings", "01", "NotFound"))
    GUICtrlCreateLabel (IniRead ($var2 & $lng &".ini", "language-settings", "02", "NotFound"), 16, 40, 546, 105)
    GUICtrlCreateLabel (IniRead ($var2 & $lng &".ini", "language-settings", "03", "NotFound"), 26, 185, 180, 21)

    $StartLng = GUICtrlCreateInput (IniRead ($var1, "language", "key", "NotFound"), 210, 185, 259, 21)

    GUICtrlCreateButton (IniRead ($var2 & $lng &".ini", "language-settings", "04", "NotFound"), 476, 185, 81, 21, 0)
    GUICtrlSetOnEvent (-1, "SRCLanguage")
    GUICtrlCreateButton (IniRead ($var2 & $lng &".ini", "messages", "02", "NotFound"), 112, 240, 129, 25, 0)
    GUICtrlSetOnEvent (-1, "OKLanguage")
    GUICtrlCreateButton (IniRead ($var2 & $lng &".ini", "messages", "03", "NotFound"), 336, 240, 129, 25, 0)
    GUICtrlSetOnEvent (-1, "ExitGUI")

  GUICtrlCreateTabItem (IniRead ($var2 & $lng &".ini", "update", "01", "NotFound"))
    GUICtrlCreateLabel (IniRead ($var2 & $lng &".ini", "update", "02", "NotFound"), 16, 40, 546, 105)

    $Radio13 = GUICtrlCreateRadio ("$Radio13", 20, 153, 17, 17)
    If IniRead ($var1, "update", "key", "NotFound") = 0 Then
      GUICtrlSetState (-1, $GUI_CHECKED)
    EndIf

    $Radio14 = GUICtrlCreateRadio ("$Radio14", 20, 185, 17, 17)
    If IniRead ($var1, "update", "key", "NotFound") = 1 Then
      GUICtrlSetState (-1, $GUI_CHECKED)
    EndIf

    GUICtrlCreateLabel (IniRead ($var2 & $lng &".ini", "update", "03", "NotFound"), 40, 153, 524, 21)
    GUICtrlCreateLabel (IniRead ($var2 & $lng &".ini", "update", "04", "NotFound"), 40, 185, 524, 21)

    GUICtrlCreateButton (IniRead ($var2 & $lng &".ini", "messages", "02", "NotFound"), 112, 240, 129, 25, 0)
    GUICtrlSetOnEvent (-1, "OKUpdate")
    GUICtrlCreateButton (IniRead ($var2 & $lng &".ini", "messages", "03", "NotFound"), 336, 240, 129, 25, 0)
    GUICtrlSetOnEvent (-1, "ExitGUI")

  GUICtrlCreateTabItem (IniRead ($var2 & $lng &".ini", "about", "01", "NotFound"))
    GUICtrlCreateLabel (". : Portable-VirtualBox Launcher v"& $version &" : .", 100, 40, 448, 26)
    GUICtrlSetFont (-1, 14, 800, 4, "Arial")
    GUICtrlCreateLabel("Download and Support: http://www.win-lite.de/wbb/index.php?page=Board&&&boardID=153", 40, 70, 500, 20)
    GUICtrlSetFont (-1, 8, 800, 0, "Arial")
    GUICtrlCreateLabel ("VirtualBox is a family of powerful x86 virtualization products for enterprise as well as home use. Not only is VirtualBox an extremely feature rich, high performance product for enterprise customers, it is also the only professional solution that is freely available as Open Source Software under the terms of the GNU General Public License (GPL).", 16, 94, 546, 55)
    GUICtrlSetFont (-1, 8, 400, 0, "Arial")
    GUICtrlCreateLabel ("Download and Support: http://www.virtualbox.org", 88, 133, 300, 14)
    GUICtrlSetFont (-1, 8, 800, 0, "Arial")
    GUICtrlCreateLabel ("Presently, VirtualBox runs on Windows, Linux, Macintosh and OpenSolaris hosts and supports a large number of guest operating systems including but not limited to Windows (NT 4.0, 2000, XP, Server 2003, Vista), DOS/Windows 3.x, Linux (2.4 and 2.6), and OpenBSD.", 16, 149, 546, 40)
    GUICtrlSetFont (-1, 8, 400, 0, "Arial")
    GUICtrlCreateLabel ("VirtualBox is being actively developed with frequent releases and has an ever growing list of features, supported guest operating systems and platforms it runs on. VirtualBox is a community effort backed by a dedicated company: everyone is encouraged to contribute while Sun ensures the product always meets professional quality criteria.", 16, 192, 546, 40)
    GUICtrlSetFont (-1, 8, 400, 0, "Arial")

    GUICtrlCreateButton (IniRead ($var2 & $lng &".ini", "messages", "03", "NotFound"), 236, 240, 129, 25, 0)
    GUICtrlSetOnEvent (-1, "ExitGUI")

  GUISetState ()
EndFunc

Func SRCUserHome ()
  Local $PathHR = FileSelectFolder (IniRead ($var2 & $lng &".ini", "srcuserhome", "01", "NotFound"), "", 1+4)
  If NOT @error Then
    GUICtrlSetState ($Radio2, $GUI_CHECKED)
    GUICtrlSetData ($HomeRoot, $PathHR)
  EndIf
EndFunc

Func OKUserHome ()
  If GUICtrlRead ($Radio1) = $GUI_CHECKED Then
    IniWrite ($var1, "userhome", "key", "%CD%\data\.VirtualBox")
    MsgBox (0, IniRead ($var2 & $lng &".ini", "messages", "04", "NotFound"), IniRead ($var2 & $lng &".ini", "messages", "05", "NotFound"))
  Else
    If GUICtrlRead ($HomeRoot) = IniRead ($var2 & $lng &".ini", "okuserhome", "01", "NotFound") Then
      MsgBox (0, IniRead ($var2 & $lng &".ini", "messages", "01", "NotFound"), IniRead ($var2 & $lng &".ini", "okuserhome", "02", "NotFound"))
    Else
      IniWrite (@ScriptDir&"\data\settings\settings.ini", "userhome", "key", GUICtrlRead ($HomeRoot))
      MsgBox (0, IniRead ($var2 & $lng &".ini", "messages", "04", "NotFound"), IniRead ($var2 & $lng &".ini", "messages", "05", "NotFound"))
    EndIf
  EndIf
EndFunc

Func SRCStartVM ()
  Local $PathVM, $VM_String, $String, $VDI, $VM_Start
  Local $Start_VM = IniRead ($var1, "startvm", "key", "NotFound")
  If IniRead ($var1, "startvm", "key", "NotFound") Then
    If FileExists (@ScriptDir&"\data\.VirtualBox\HardDisks\") Then
      $PathVM = FileOpenDialog (IniRead ($var2 & $lng &".ini", "srcstartvm", "01", "NotFound"), $Start_VM&"\.VirtualBox\HardDisks", "VirtualBox VM (*.vdi)", 1+2)
    EndIf
  Else
    If FileExists (@ScriptDir&"\data\.VirtualBox\HardDisks\") Then
      $PathVM = FileOpenDialog (IniRead ($var2 & $lng &".ini", "srcstartvm", "01", "NotFound"), @ScriptDir&"\data\.VirtualBox\HardDisks", "VirtualBox VM (*.vdi)", 1+2)
    EndIf
  EndIf
  If NOT @error Then
    $VM_String = StringSplit ($PathVM, "\")
    $String = ""
    For $VDI In $VM_String
      $String = $VDI
    Next
    $VM_Start = StringSplit ($String, ".")
    GUICtrlSetState ($Radio4, $GUI_CHECKED)
    GUICtrlSetData ($VMStart, $VM_Start[1])
  EndIf
EndFunc

Func OKStartVM ()
  If GUICtrlRead ($Radio3) = $GUI_CHECKED Then
    IniWrite ($var1, "startvm", "key", "")
    MsgBox (0, IniRead ($var2 & $lng &".ini", "messages", "04", "NotFound"), IniRead ($var2 & $lng &".ini", "messages", "05", "NotFound"))
  Else
    If GUICtrlRead ($VMStart) = IniRead ($var2 & $lng &".ini", "okstartvm", "01", "NotFound") Then
      MsgBox (0, IniRead (@ScriptDir&"\data\language\"& $lng &".ini", "messages", "01", "NotFound"), IniRead ($var2 & $lng &".ini", "okstartvm", "02", "NotFound"))
    Else
      IniWrite ($var1, "startvm", "key", GUICtrlRead ($VMStart))
      MsgBox (0, IniRead ($var2 & $lng &".ini", "messages", "04", "NotFound"), IniRead ($var2 & $lng &".ini", "messages", "05", "NotFound"))
    EndIf
  EndIf
EndFunc

Func OKHotKeys ()
  If GUICtrlRead ($Radio5) = $GUI_CHECKED Then
    IniWrite ($var1, "hotkeys", "key", "1")
    MsgBox (0, IniRead ($var2 & $lng &".ini", "messages", "04", "NotFound"), IniRead ($var2 & $lng &".ini", "messages", "05", "NotFound"))
  Else
    IniWrite ($var1, "hotkeys", "key", "0")
    MsgBox (0, IniRead ($var2 & $lng &".ini", "messages", "04", "NotFound"), IniRead ($var2 & $lng &".ini", "messages", "05", "NotFound"))
  EndIf
EndFunc

Func OKHotKeysSet ()
  If GUICtrlRead ($Radio7) = $GUI_CHECKED Then
    IniWrite ($var1, "hotkeys", "userkey", "0")
    IniWrite ($var1, "hotkeys", "01", "^")
    IniWrite ($var1, "hotkeys", "02", "^")
    IniWrite ($var1, "hotkeys", "03", "^")
    IniWrite ($var1, "hotkeys", "04", "^")
    IniWrite ($var1, "hotkeys", "05", "^")
    IniWrite ($var1, "hotkeys", "06", "^")

    IniWrite ($var1, "hotkeys", "07", "")
    IniWrite ($var1, "hotkeys", "08", "")
    IniWrite ($var1, "hotkeys", "09", "")
    IniWrite ($var1, "hotkeys", "10", "")
    IniWrite ($var1, "hotkeys", "11", "")
    IniWrite ($var1, "hotkeys", "12", "")

    IniWrite ($var1, "hotkeys", "13", "")
    IniWrite ($var1, "hotkeys", "14", "")
    IniWrite ($var1, "hotkeys", "15", "")
    IniWrite ($var1, "hotkeys", "16", "")
    IniWrite ($var1, "hotkeys", "17", "")
    IniWrite ($var1, "hotkeys", "18", "")

    IniWrite ($var1, "hotkeys", "19", "1")
    IniWrite ($var1, "hotkeys", "20", "2")
    IniWrite ($var1, "hotkeys", "21", "3")
    IniWrite ($var1, "hotkeys", "22", "4")
    IniWrite ($var1, "hotkeys", "23", "5")
    IniWrite ($var1, "hotkeys", "24", "6")
    MsgBox (0, IniRead ($var2 & $lng &".ini", "messages", "04", "NotFound"), IniRead ($var2 & $lng &".ini", "messages", "05", "NotFound"))
  Else
    If GUICtrlRead ($Input1) = false OR GUICtrlRead ($Input2) = false OR GUICtrlRead ($Input3) = false OR GUICtrlRead ($Input4) = false OR GUICtrlRead ($Input5) = false OR GUICtrlRead ($Input6) = false Then
      MsgBox (0, IniRead ($var2 & $lng &".ini", "messages", "01", "NotFound"), IniRead ($var2 & $lng &".ini", "okhotkeysset", "01", "NotFound"))
    Else
      IniWrite ($var1, "hotkeys", "userkey", "1")
      If GUICtrlRead ($CheckBox01) = $GUI_CHECKED Then
        IniWrite ($var1, "hotkeys", "01", "^")
      Else
        IniWrite ($var1, "hotkeys", "01", "")
      EndIf
      If GUICtrlRead ($CheckBox02) = $GUI_CHECKED Then
        IniWrite ($var1, "hotkeys", "02", "^")
      Else
        IniWrite ($var1, "hotkeys", "02", "")
      EndIf
      If GUICtrlRead ($CheckBox03) = $GUI_CHECKED Then
        IniWrite ($var1, "hotkeys", "03", "^")
      Else
        IniWrite ($var1, "hotkeys", "03", "")
      EndIf
      If GUICtrlRead ($CheckBox04) = $GUI_CHECKED Then
        IniWrite ($var1, "hotkeys", "04", "^")
      Else
        IniWrite ($var1, "hotkeys", "04", "")
      EndIf
      If GUICtrlRead ($CheckBox05) = $GUI_CHECKED Then
        IniWrite ($var1, "hotkeys", "05", "^")
      Else
        IniWrite ($var1, "hotkeys", "05", "")
      EndIf
      If GUICtrlRead ($CheckBox06) = $GUI_CHECKED Then
        IniWrite ($var1, "hotkeys", "06", "^")
      Else
        IniWrite ($var1, "hotkeys", "06", "")
      EndIf

      If GUICtrlRead ($CheckBox07) = $GUI_CHECKED Then
        IniWrite ($var1, "hotkeys", "07", "!")
      Else
        IniWrite ($var1, "hotkeys", "07", "")
      EndIf
      If GUICtrlRead ($CheckBox08) = $GUI_CHECKED Then
        IniWrite ($var1, "hotkeys", "08", "!")
      Else
        IniWrite ($var1, "hotkeys", "08", "")
      EndIf
      If GUICtrlRead ($CheckBox09) = $GUI_CHECKED Then
        IniWrite ($var1, "hotkeys", "09", "!")
      Else
        IniWrite ($var1, "hotkeys", "09", "")
      EndIf
      If GUICtrlRead ($CheckBox10) = $GUI_CHECKED Then
        IniWrite ($var1, "hotkeys", "10", "!")
      Else
        IniWrite ($var1, "hotkeys", "10", "")
      EndIf
      If GUICtrlRead ($CheckBox11) = $GUI_CHECKED Then
        IniWrite ($var1, "hotkeys", "11", "!")
      Else
        IniWrite ($var1, "hotkeys", "11", "")
      EndIf
      If GUICtrlRead ($CheckBox12) = $GUI_CHECKED Then
        IniWrite ($var1, "hotkeys", "12", "!")
      Else
        IniWrite ($var1, "hotkeys", "12", "")
      EndIf

      If GUICtrlRead ($CheckBox13) = $GUI_CHECKED Then
        IniWrite ($var1, "hotkeys", "13", "+")
      Else
        IniWrite ($var1, "hotkeys", "13", "")
      EndIf
      If GUICtrlRead ($CheckBox14) = $GUI_CHECKED Then
        IniWrite ($var1, "hotkeys", "14", "+")
      Else
        IniWrite ($var1, "hotkeys", "14", "")
      EndIf
      If GUICtrlRead ($CheckBox15) = $GUI_CHECKED Then
        IniWrite ($var1, "hotkeys", "15", "+")
      Else
        IniWrite ($var1, "hotkeys", "15", "")
      EndIf
      If GUICtrlRead ($CheckBox16) = $GUI_CHECKED Then
        IniWrite ($var1, "hotkeys", "16", "+")
      Else
        IniWrite ($var1, "hotkeys", "16", "")
      EndIf
      If GUICtrlRead ($CheckBox17) = $GUI_CHECKED Then
        IniWrite ($var1, "hotkeys", "17", "+")
      Else
        IniWrite ($var1, "hotkeys", "17", "")
      EndIf
      If GUICtrlRead ($CheckBox18) = $GUI_CHECKED Then
        IniWrite ($var1, "hotkeys", "18", "+")
      Else
        IniWrite ($var1, "hotkeys", "18", "")
      EndIf

      IniWrite ($var1, "hotkeys", "19", GUICtrlRead ($Input1))
      IniWrite ($var1, "hotkeys", "20", GUICtrlRead ($Input2))
      IniWrite ($var1, "hotkeys", "21", GUICtrlRead ($Input3))
      IniWrite ($var1, "hotkeys", "22", GUICtrlRead ($Input4))
      IniWrite ($var1, "hotkeys", "23", GUICtrlRead ($Input5))
      IniWrite ($var1, "hotkeys", "24", GUICtrlRead ($Input6))
      MsgBox (0, IniRead ($var2 & $lng &".ini", "messages", "04", "NotFound"), IniRead ($var2 & $lng &".ini", "messages", "05", "NotFound"))
    EndIf
  EndIf
EndFunc

Func OKUSB ()
  If GUICtrlRead ($Radio9) = $GUI_CHECKED Then
    IniWrite ($var1, "usb", "key", "0")
    MsgBox (0, IniRead ($var2 & $lng &".ini", "messages", "04", "NotFound"), IniRead ($var2 & $lng &".ini", "messages", "05", "NotFound"))
  Else
    IniWrite ($var1, "usb", "key", "1")
    MsgBox (0, IniRead ($var2 & $lng &".ini", "messages", "04", "NotFound"), IniRead ($var2 & $lng &".ini", "messages", "05", "NotFound"))
  EndIf
EndFunc

Func OKNet ()
  If GUICtrlRead ($Radio11) = $GUI_CHECKED Then
    IniWrite ($var1, "net", "key", "0")
    MsgBox (0, IniRead ($var2 & $lng &".ini", "messages", "04", "NotFound"), IniRead ($var2 & $lng &".ini", "messages", "05", "NotFound"))
  Else
    IniWrite ($var1, "net", "key", "1")
    MsgBox (0, IniRead ($var2 & $lng &".ini", "messages", "04", "NotFound"), IniRead ($var2 & $lng &".ini", "messages", "05", "NotFound"))
  EndIf
EndFunc

Func SRCLanguage ()
  Local $Language_String, $String, $Language, $Language_Start
  Local $PathLanguage = FileOpenDialog (IniRead ($var2 & $lng &".ini", "srcslanguage", "01", "NotFound"), @ScriptDir&"\data\language", "(*.ini)", 1+2)
  If NOT @error Then
    $Language_String = StringSplit ($PathLanguage, "\")
    $String = ""
    For $Language In $Language_String
      $String  = $Language
    Next
    $Language_Start = StringSplit ($String, ".")
    GUICtrlSetData ($StartLng, $Language_Start[1])
  EndIf
EndFunc

Func OKLanguage ()
  If GUICtrlRead ($StartLng) = "" Then
    MsgBox (0, IniRead ($var2 & $lng &".ini", "messages", "01", "NotFound"), IniRead ($var2 & $lng &".ini", "oklanguage", "01", "NotFound"))
  Else
    IniWrite ($var1, "language", "key", GUICtrlRead ($StartLng))
	If IniRead ($var1, "lang", "key", "NotFound") = 1 Then
      MsgBox (0, IniRead ($var2 & $lng &".ini", "messages", "04", "NotFound"), IniRead ($var2 & $lng &".ini", "messages", "05", "NotFound"))
	EndIf
	$cl = 0
  EndIf
EndFunc

Func OKUpdate ()
  If GUICtrlRead ($Radio13) = $GUI_CHECKED Then
    IniWrite ($var1, "update", "key", "0")
    MsgBox (0, IniRead ($var2 & $lng &".ini", "messages", "04", "NotFound"), IniRead ($var2 & $lng &".ini", "messages", "05", "NotFound"))
  Else
    IniWrite ($var1, "update", "key", "1")
    MsgBox (0, IniRead ($var2 & $lng &".ini", "messages", "04", "NotFound"), IniRead ($var2 & $lng &".ini", "messages", "05", "NotFound"))
  EndIf
EndFunc

Func ExitGUI ()
  GUIDelete ()
  $cl = 0
EndFunc

Func ExitScript ()
  Opt ("WinTitleMatchMode", 2)
  WinClose ("] - Oracle VM VirtualBox", "")
  WinWaitClose ("] - Oracle VM VirtualBox", "")
  WinClose ("Oracle VM VirtualBox", "")
  Break (1)
EndFunc

Func DownloadFile ()
  Local $download1 = InetGet (IniRead (@ScriptDir&"\data\settings\vboxinstall.ini", "download", "key1", "NotFound"), $pwd&"\VirtualBox.exe", 1, 1)
  Local $download2 = IniRead (@ScriptDir&"\data\settings\vboxinstall.ini", "download", "key1", "NotFound")
  Do
    Sleep (250)
    Local $bytes = 0
    $bytes = InetGetInfo($download1, 0)
	$total_bytes = InetGetInfo($download1, 1)
    GUICtrlSetData ($Input200, IniRead ($var2 & $lng &".ini", "status", "01", "NotFound") &" "& $download2 & @LF & DisplayDownloadStatus($bytes,$total_bytes) )
	;GUICtrlSetData($ProgressBar1,Round(100*$bytes/$total_bytes)) ; <<<TODO: Ticket 3509714
  Until InetGetInfo ($download1, 2)
  InetClose ($download1)
  Local $download3 = InetGet (IniRead (@ScriptDir&"\data\settings\vboxinstall.ini", "download", "key2", "NotFound"), $pwd&"\Extension", 1, 1)
  Local $download4 = IniRead (@ScriptDir&"\data\settings\vboxinstall.ini", "download", "key2", "NotFound")
  $total_bytes = InetGetInfo($download3, 1)
  Do
    Sleep (250)
    Local $bytes = 0
    $bytes = InetGetInfo($download3, 0)
	$total_bytes = InetGetInfo($download3, 1)
    GUICtrlSetData ($Input200, $download4 & @LF & DisplayDownloadStatus($bytes,$total_bytes))
  Until InetGetInfo ($download3, 2)
  InetClose ($download3)
  If FileExists (@ScriptDir&"\virtualbox.exe") Then
    GUICtrlSetData ($Input100, @ScriptDir&"\virtualbox.exe")
  EndIf
  GUICtrlSetData ($Input200, @LF & IniRead ($var2 & $lng &".ini", "status", "02", "NotFound"))
  $bytes = 0
EndFunc

Func DisplayDownloadStatus($downloaded_bytes,$total_bytes)
	if $total_bytes > 0 Then
		Return RoundForceDecimalMB($downloaded_bytes)& "MB / "&RoundForceDecimalMB($total_bytes)&"MB ("&Round(100*$downloaded_bytes/$total_bytes)&"%)"
	Else
		Return RoundForceDecimalMB($downloaded_bytes)& "MB"
	EndIf
EndFunc

Func RoundForceDecimalMB($number)
	$rounded = Round($number/1048576, 1)
	If Not StringInStr($rounded, ".") Then
		Return $rounded & ".0"
	Else
		Return $rounded
	EndIf
EndFunc   ;==>RoundForceDecimal

Func SearchFile ()
  Local $FilePath = FileOpenDialog (IniRead ($var2 & $lng &".ini", "status", "03", "NotFound"), @ScriptDir, "(*.exe)", 1+2)
  If NOT @error Then
    GUICtrlSetData ($Input100, $FilePath)
  EndIf
EndFunc

Func UseSettings ()
  If GUICtrlRead ($Input100) = "" OR GUICtrlRead ($Input100) = IniRead ($var2 & $lng &".ini", "download", "05", "NotFound") Then
    Local $SourceFile = @ScriptDir&"\forgetit"
  Else
    Local $SourceFile = GUICtrlRead ($Input100)
  EndIf

  If NOT (FileExists (@ScriptDir&"\virtualbox.exe") OR FileExists ($SourceFile)) AND (GUICtrlRead ($Checkbox100) = $GUI_CHECKED OR GUICtrlRead ($Checkbox110) = $GUI_CHECKED) Then
    Break (1)
    Exit
  EndIf

  If (FileExists (@ScriptDir&"\virtualbox.exe") OR FileExists ($SourceFile)) AND (GUICtrlRead ($Checkbox100) = $GUI_CHECKED OR GUICtrlRead ($Checkbox110) = $GUI_CHECKED) Then
    GUICtrlSetData ($Input200, @LF & IniRead ($var2 & $lng &".ini", "status", "04", "NotFound"))
    If FileExists (@ScriptDir&"\virtualbox.exe") Then
      Run (@ScriptDir & "\virtualbox.exe --extract --path temp", @ScriptDir, @SW_HIDE)
      Opt ("WinTitleMatchMode", 2)
      WinWait ("VirtualBox Installer", "")
      ControlClick ("VirtualBox Installer", "OK", "TButton1")
      WinClose ("VirtualBox Installer", "")
    EndIf

    If FileExists ($SourceFile) Then
      Run ($SourceFile & " --extract --path temp", @ScriptDir, @SW_HIDE)
      Opt ("WinTitleMatchMode", 2)
      WinWait ("VirtualBox Installer", "")
      ControlClick ("VirtualBox Installer", "OK", "TButton1")
      WinClose ("VirtualBox Installer", "")
    EndIf
  EndIf

  If FileExists (@ScriptDir&"\Extension") Then
    If FileExists (@ScriptDir&"\Extension") Then
      RunWait (@ScriptDir & "\data\tools\7za.exe x -o"& @ScriptDir &"\temp\ "& @ScriptDir &"\Extension", @ScriptDir, @SW_HIDE)
      RunWait (@ScriptDir & "\data\tools\7za.exe x -o"& @ScriptDir &"\temp\ExtensionPacks\Oracle_VM_VirtualBox_Extension_Pack\ "& @ScriptDir &"\temp\Extension~", @ScriptDir, @SW_HIDE)
    EndIf
  EndIf

  If GUICtrlRead ($Checkbox100) = $GUI_CHECKED AND FileExists (@ScriptDir&"\temp") Then
    GUICtrlSetData ($Input200, @LF & IniRead ($var2 & $lng &".ini", "status", "05", "NotFound"))
    RunWait ("cmd /c ren ""%CD%\temp\*.msi"" x86.msi", @ScriptDir, @SW_HIDE)
    RunWait ("cmd /c msiexec.exe /quiet /a ""%CD%\temp\x86.msi"" TARGETDIR=""%CD%\temp\x86""", @ScriptDir, @SW_HIDE)
    DirCopy (@ScriptDir&"\temp\x86\PFiles\Oracle\VirtualBox", @ScriptDir&"\app32", 1)
    FileCopy (@ScriptDir&"\temp\x86\PFiles\Oracle\VirtualBox\*", @ScriptDir&"\app32", 9)
    DirRemove (@ScriptDir&"\app32\accessible", 1)
    DirRemove (@ScriptDir&"\app32\sdk", 1)
  EndIf

  If GUICtrlRead ($Checkbox110) = $GUI_CHECKED AND FileExists (@ScriptDir&"\temp") Then
    GUICtrlSetData ($Input200, @LF & IniRead ($var2 & $lng &".ini", "status", "05", "NotFound"))
    RunWait ("cmd /c ren ""%CD%\temp\*.msi"" amd64.msi", @ScriptDir, @SW_HIDE)
    RunWait ("cmd /c msiexec.exe /quiet /a ""%CD%\temp\amd64.msi"" TARGETDIR=""%CD%\temp\x64""", @ScriptDir, @SW_HIDE)
    DirCopy (@ScriptDir&"\temp\x64\PFiles\Oracle\VirtualBox", @ScriptDir&"\app64", 1)
    FileCopy (@ScriptDir&"\temp\x64\PFiles\Oracle\VirtualBox\*", @ScriptDir&"\app64", 9)
    DirRemove (@ScriptDir&"\app64\accessible", 1)
    DirRemove (@ScriptDir&"\app64\sdk", 1)
  EndIf

#cs
  If GUICtrlRead ($Checkbox120) = $GUI_CHECKED Then
    GUICtrlSetData ($Input200, @LF & IniRead ($var2 & $lng &".ini", "status", "06", "NotFound"))
    If FileExists (@ScriptDir&"\app32") AND GUICtrlRead ($Checkbox100) = $GUI_CHECKED Then
	  ; Thibaut : some files will trigger Virus alerts if compressed ( VBoxTestOGL.exe and VBoxNetDHCP.exe)
      FileCopy (@ScriptDir&"\data\tools\upx.exe", @ScriptDir&"\app32")
      RunWait ("cmd /c upx VRDPAuth.dll", @ScriptDir&"\app32", @SW_HIDE)
      RunWait ("cmd /c upx VirtualBox.exe", @ScriptDir&"\app32", @SW_HIDE)
      RunWait ("cmd /c upx vboxwebsrv.exe", @ScriptDir&"\app32", @SW_HIDE)
      RunWait ("cmd /c upx VBoxVRDP.dll", @ScriptDir&"\app32", @SW_HIDE)
      RunWait ("cmd /c upx VBoxVMM.dll", @ScriptDir&"\app32", @SW_HIDE)
      ;RunWait ("cmd /c upx VBoxTestOGL.exe", @ScriptDir&"\app32", @SW_HIDE)
      RunWait ("cmd /c upx VBoxSVC.exe", @ScriptDir&"\app32", @SW_HIDE)
      RunWait ("cmd /c upx VBoxSharedFolders.dll", @ScriptDir&"\app32", @SW_HIDE)
      RunWait ("cmd /c upx VBoxSharedCrOpenGL.dll", @ScriptDir&"\app32", @SW_HIDE)
      RunWait ("cmd /c upx VBoxSharedClipboard.dll", @ScriptDir&"\app32", @SW_HIDE)
      RunWait ("cmd /c upx VBoxSDL.exe", @ScriptDir&"\app32", @SW_HIDE)
      RunWait ("cmd /c upx VBoxRT.dll", @ScriptDir&"\app32", @SW_HIDE)
      RunWait ("cmd /c upx VBoxREM32.dll", @ScriptDir&"\app32", @SW_HIDE)
      RunWait ("cmd /c upx VBoxREM64.dll", @ScriptDir&"\app32", @SW_HIDE)
      RunWait ("cmd /c upx VBoxREM.dll", @ScriptDir&"\app32", @SW_HIDE)
      RunWait ("cmd /c upx VBoxOGLrenderspu.dll", @ScriptDir&"\app32", @SW_HIDE)
      RunWait ("cmd /c upx VBoxOGLhosterrorspu.dll", @ScriptDir&"\app32", @SW_HIDE)
      RunWait ("cmd /c upx VBoxOGLhostcrutil.dll", @ScriptDir&"\app32", @SW_HIDE)
      ;RunWait ("cmd /c upx VBoxNetDHCP.exe", @ScriptDir&"\app32", @SW_HIDE)
      ;RunWait ("cmd /c upx VBoxManage.exe", @ScriptDir&"\app32", @SW_HIDE)
      RunWait ("cmd /c upx VBoxHeadless.exe", @ScriptDir&"\app32", @SW_HIDE)
      RunWait ("cmd /c upx VBoxGuestPropSvc.dll", @ScriptDir&"\app32", @SW_HIDE)
      RunWait ("cmd /c upx VBoxDDU.dll", @ScriptDir&"\app32", @SW_HIDE)
      RunWait ("cmd /c upx VBoxDD2.dll", @ScriptDir&"\app32", @SW_HIDE)
      RunWait ("cmd /c upx VBoxDD.dll", @ScriptDir&"\app32", @SW_HIDE)
      RunWait ("cmd /c upx VBoxDbg.dll", @ScriptDir&"\app32", @SW_HIDE)
      RunWait ("cmd /c upx SDL_ttf.dll", @ScriptDir&"\app32", @SW_HIDE)
      RunWait ("cmd /c upx SDL.dll", @ScriptDir&"\app32", @SW_HIDE)
      RunWait ("cmd /c upx QtOpenGLVBox4.dll", @ScriptDir&"\app32", @SW_HIDE)
      RunWait ("cmd /c upx QtNetworkVBox4.dll", @ScriptDir&"\app32", @SW_HIDE)
      RunWait ("cmd /c upx QtGUIVBox4.dll", @ScriptDir&"\app32", @SW_HIDE)
      RunWait ("cmd /c upx QtCoreVBox4.dll", @ScriptDir&"\app32", @SW_HIDE)
      RunWait ("cmd /c upx msvcr.dll", @ScriptDir&"\app32", @SW_HIDE)
      RunWait ("cmd /c upx msvcr71.dll", @ScriptDir&"\app32", @SW_HIDE)
      RunWait ("cmd /c upx msvcp71.dll", @ScriptDir&"\app32", @SW_HIDE)
      FileDelete (@ScriptDir&"\app32\upx.exe")
    EndIf
    If FileExists (@ScriptDir&"\app64") AND GUICtrlRead ($Checkbox110) = $GUI_CHECKED Then
      FileCopy (@ScriptDir&"\data\tools\mpress.exe", @ScriptDir&"\app64")
      RunWait ("cmd /c mpress VRDPAuth.dll", @ScriptDir&"\app64", @SW_HIDE)
      RunWait ("cmd /c mpress VirtualBox.exe", @ScriptDir&"\app64", @SW_HIDE)
      RunWait ("cmd /c mpress vboxwebsrv.exe", @ScriptDir&"\app64", @SW_HIDE)
      RunWait ("cmd /c mpress VBoxVRDP.dll", @ScriptDir&"\app64", @SW_HIDE)
      RunWait ("cmd /c mpress VBoxVMM.dll", @ScriptDir&"\app64", @SW_HIDE)
      ;RunWait ("cmd /c mpress VBoxTestOGL.exe", @ScriptDir&"\app64", @SW_HIDE)
      RunWait ("cmd /c mpress VBoxSVC.exe", @ScriptDir&"\app64", @SW_HIDE)
      RunWait ("cmd /c mpress VBoxSharedFolders.dll", @ScriptDir&"\app64", @SW_HIDE)
      RunWait ("cmd /c mpress VBoxSharedCrOpenGL.dll", @ScriptDir&"\app64", @SW_HIDE)
      RunWait ("cmd /c mpress VBoxSharedClipboard.dll", @ScriptDir&"\app64", @SW_HIDE)
      RunWait ("cmd /c mpress VBoxSDL.exe", @ScriptDir&"\app64", @SW_HIDE)
      RunWait ("cmd /c mpress VBoxRT.dll", @ScriptDir&"\app64", @SW_HIDE)
      RunWait ("cmd /c mpress VBoxREM.dll", @ScriptDir&"\app64", @SW_HIDE)
      RunWait ("cmd /c mpress VBoxOGLrenderspu.dll", @ScriptDir&"\app64", @SW_HIDE)
      RunWait ("cmd /c mpress VBoxOGLhosterrorspu.dll", @ScriptDir&"\app64", @SW_HIDE)
      RunWait ("cmd /c mpress VBoxOGLhostcrutil.dll", @ScriptDir&"\app64", @SW_HIDE)
      ;RunWait ("cmd /c mpress VBoxNetDHCP.exe", @ScriptDir&"\app64", @SW_HIDE)
      ;RunWait ("cmd /c mpress VBoxManage.exe", @ScriptDir&"\app64", @SW_HIDE)
      RunWait ("cmd /c mpress VBoxHeadless.exe", @ScriptDir&"\app64", @SW_HIDE)
      RunWait ("cmd /c mpress VBoxGuestPropSvc.dll", @ScriptDir&"\app64", @SW_HIDE)
      RunWait ("cmd /c mpress VBoxDDU.dll", @ScriptDir&"\app64", @SW_HIDE)
      RunWait ("cmd /c mpress VBoxDD2.dll", @ScriptDir&"\app64", @SW_HIDE)
      RunWait ("cmd /c mpress VBoxDD.dll", @ScriptDir&"\app64", @SW_HIDE)
      RunWait ("cmd /c mpress VBoxDbg.dll", @ScriptDir&"\app64", @SW_HIDE)
      RunWait ("cmd /c mpress SDL.dll", @ScriptDir&"\app64", @SW_HIDE)
      RunWait ("cmd /c mpress QtOpenGLVBox4.dll", @ScriptDir&"\app32", @SW_HIDE)
      RunWait ("cmd /c mpress QtNetworkVBox4.dll", @ScriptDir&"\app64", @SW_HIDE)
      RunWait ("cmd /c mpress QtGUIVBox4.dll", @ScriptDir&"\app64", @SW_HIDE)
      RunWait ("cmd /c mpress QtCoreVBox4.dll", @ScriptDir&"\app64", @SW_HIDE)
      RunWait ("cmd /c mpress msvcr80.dll", @ScriptDir&"\app64", @SW_HIDE)
      RunWait ("cmd /c mpress msvcp80.dll", @ScriptDir&"\app64", @SW_HIDE)
      FileDelete (@ScriptDir&"\app64\mpress.exe")
    EndIf
  EndIf
#ce

  If GUICtrlRead ($Checkbox100) = $GUI_CHECKED AND GUICtrlRead ($Checkbox110) = $GUI_CHECKED Then
    GUICtrlSetData ($Input200, @LF & "Please wait, delete files and folders.")
    DirCopy (@ScriptDir&"\temp\x86\PFiles\Oracle\VirtualBox\", @ScriptDir&"\vboxadditions", 1)
    DirCopy (@ScriptDir&"\temp\ExtensionPacks\", @ScriptDir&"\vboxadditions\ExtensionPacks", 1)
    FileCopy (@ScriptDir&"\temp\x86\PFiles\Oracle\VirtualBox\*.iso", @ScriptDir&"\vboxadditions\guestadditions\*.iso", 9)
    DirRemove (@ScriptDir&"\vboxadditions\accessible", 1)
    DirRemove (@ScriptDir&"\vboxadditions\drivers", 1)
    DirRemove (@ScriptDir&"\vboxadditions\sdk", 1)
    FileDelete (@ScriptDir&"\vboxadditions\*.*")
    DirRemove (@ScriptDir&"\app32\doc", 1)
    DirRemove (@ScriptDir&"\app32\nls", 1)
    FileDelete (@ScriptDir&"\app32\*.iso")
    DirRemove (@ScriptDir&"\app64\doc", 1)
    DirRemove (@ScriptDir&"\app64\nls", 1)
    FileDelete (@ScriptDir&"\app64\*.iso")
  EndIf

  If FileExists (@ScriptDir&"\temp") Then
    DirRemove (@ScriptDir&"\temp", 1)
    FileDelete (@ScriptDir&"\virtualbox.exe")
    FileDelete (@ScriptDir&"\extension")
  EndIf

  If GUICtrlRead ($Checkbox130) = $GUI_CHECKED Then
    IniWrite (@ScriptDir&"\data\settings\vboxinstall.ini", "startvbox", "key", "1")
  Else
    IniWrite (@ScriptDir&"\data\settings\vboxinstall.ini", "startvbox", "key", "0")
  EndIf

  If (FileExists (@ScriptDir&"\virtualbox.exe") OR FileExists ($SourceFile)) AND (GUICtrlRead ($Checkbox100) = $GUI_CHECKED OR GUICtrlRead ($Checkbox110) = $GUI_CHECKED) Then
    GUICtrlSetData ($Input200, @LF & IniRead ($var2 & $lng &".ini", "status", "08", "NotFound"))
    Sleep (2000)
  EndIf

  GUIDelete ()
  $install = 0
EndFunc

Func Licence ()
  _IECreate ("http://www.virtualbox.org/wiki/VirtualBox_PUEL", 1, 1)
EndFunc

Func ExitExtraction ()
  GUIDelete ()
  $install = 0

  Break (1)
  Exit
EndFunc

Func UpdateYes ()
  If $new1 = 1 Then
    Local $hDownload = InetGet ($updateUrl&"vboxinstall.dat", @ScriptDir&"\data\settings\vboxinstall.ini", 1, 1)
    Do
      Sleep (250)
    Until InetGetInfo ($hDownload, 2)
    InetClose ($hDownload)

    If GUICtrlRead ($Checkbox200) = $GUI_CHECKED Then
      GUICtrlSetData ($Input300, IniRead ($var2 & $lng &".ini", "status", "09", "NotFound"))
      DirMove (@ScriptDir&"\app32", @ScriptDir&"\app32_BAK", 1)
      DirMove (@ScriptDir&"\app64", @ScriptDir&"\app64_BAK", 1)
      DirMove (@ScriptDir&"\vboxadditions", @ScriptDir&"\vboxadditions_BAK", 1)
    Else
      GUICtrlSetData ($Input300, IniRead ($var2 & $lng &".ini", "status", "07", "NotFound"))
      DirRemove (@ScriptDir&"\app32", 1)
      DirRemove (@ScriptDir&"\app64", 1)
      DirRemove (@ScriptDir&"\vboxadditions", 1)
    EndIf

    IniWrite ($var1, "version", "key", IniRead (@TempDir&"\update.ini", "version", "key", "NotFound"))
  EndIf

  If $new2 = 1 Then
    DirCreate (@ScriptDir&"\update\")
    GUICtrlSetData ($Input300, IniRead ($var2 & $lng &".ini", "status", "10", "NotFound"))

    Local $vboxdown = IniRead ($updateUrl&"download.ini", "download", "key", "NotFound")
    IniWrite ($updateUrl&"download.ini", "download", "key", $vboxdown + 1)

    Local $hDownload = InetGet ($updateUrl&"vbox.7z", @ScriptDir&"\update\vbox.7z", 1, 1)
    Do
      Sleep (250)
    Until InetGetInfo ($hDownload, 2)
    InetClose ($hDownload)

    GUICtrlSetData ($Input300, IniRead ($var2 & $lng &".ini", "status", "04", "NotFound"))
    Sleep (2000)

    If FileExists (@ScriptDir&"\update\vbox.7z") Then
      RunWait (@ScriptDir&"\data\tools\7za.exe x -o"& @ScriptDir&"\update\ "& @ScriptDir&"\update\vbox.7z", @ScriptDir, @SW_HIDE)
    EndIf

    GUICtrlSetData ($Input300, IniRead ($var2 & $lng &".ini", "status", "11", "NotFound"))

    If GUICtrlRead ($Checkbox200) = $GUI_CHECKED Then
      DirMove (@ScriptDir&"\data\language", @ScriptDir&"\data\language_BAK", 1)
      DirMove (@ScriptDir&"\data\tools", @ScriptDir&"\data\tools_BAK", 1)
      DirMove (@ScriptDir&"\source", @ScriptDir&"\source_BAK", 1)
    Else
      DirRemove (@ScriptDir&"\data\language", 1)
      DirRemove (@ScriptDir&"\data\tools", 1)
      DirRemove (@ScriptDir&"\source", 1)
      FileDelete (@ScriptDir&"\LiesMich.txt")
      FileDelete (@ScriptDir&"\ReadMe.txt")
    EndIf

    Sleep (2000)

    DirMove (@ScriptDir&"\update\Portable-VirtualBox\data\language", @ScriptDir&"\data", 1)
    DirMove (@ScriptDir&"\update\Portable-VirtualBox\data\tools", @ScriptDir&"\data", 1)
    DirMove (@ScriptDir&"\update\Portable-VirtualBox\source", @ScriptDir, 1)
    FileMove (@ScriptDir&"\update\Portable-VirtualBox\LiesMich.txt", @ScriptDir, 9)
    FileMove (@ScriptDir&"\update\Portable-VirtualBox\ReadMe.txt", @ScriptDir, 9)
    FileMove (@ScriptDir&"\update\Portable-VirtualBox\Portable-VirtualBox.exe", @ScriptDir&"\Portable-VirtualBox.exe_NEW", 9)
    FileMove (@ScriptDir&"\update\Portable-VirtualBox\UpDate.exe", @ScriptDir&"\update.exe", 9)

    IniWrite ($var1, "starter", "key", IniRead (@TempDir&"\update.ini", "starter", "key", "NotFound"))
  EndIf

  GUICtrlSetData ($Input300, IniRead ($var2 & $lng &".ini", "status", "12", "NotFound"))
  Sleep (2000)

  GUIDelete ()
  $update = 0

  If $new2 = 1 Then
    Run (@ScriptDir&"\update.exe")
    Break (1)
    Exit
  EndIf
EndFunc

Func UpdateNo ()
  GUIDelete ()
  $update = 0
EndFunc

; Check if virtualbox is installed and run from it
Func HybridMode()
	if @OSArch="X64" Then
		$append_arch="64"
	Else
		$append_arch=""
	EndIf

	; Version of VirtualBox 4.X
	$version_new = RegRead("HKLM"&$append_arch&"\SOFTWARE\Oracle\VirtualBox","Version")

	; Since 4.0.8 ... Version is in VersionExt key in registry
	if $version_new = "%VER%" Then
		$version_new = RegRead("HKLM"&$append_arch&"\SOFTWARE\Oracle\VirtualBox","VersionExt")
	EndIf

	; Version of VirtualBox 3.X if any is installed => Cannot run Portable 4.X or it will corrupt it
	$version_old = RegRead("HKLM"&$append_arch&"\SOFTWARE\Sun\VirtualBox","Version")

	; if old version => Exit to avoid corruption of services
	if ($version_new <> "" AND Int(StringLeft($version_new,1))<4 ) OR $version_old <> "" Then
		MsgBox(16,"Sorry","Please update your version of VirtualBox to 4.X or uninstall it from your computer to be able to run this portable version"&@CRLF&@CRLF&"This is a security in order to avoid corrupting your current installed version."&@CRLF&@CRLF &"Thank you for your comprehension.")
		Exit
	EndIf

	; Setting VBOX_USER_HOME to portable virtualbox directory (VM settings stays in this one)
	EnvSet("VBOX_USER_HOME",@ScriptDir&"\data\.VirtualBox")

	; Testing if major version of regular vbox is 4 then running from it
	If $version_new <> "" AND StringLeft($version_new,1)>=4 Then

		; Getting the installation directory of regular VirtualBox from registry
		$nonportable_install_dir=RegRead("HKLM"&$append_arch&"\SOFTWARE\Oracle\VirtualBox","InstallDir")

		if $CmdLine[0] = 1 Then
			Run('cmd /c ""'&$nonportable_install_dir&'VBoxManage.exe" startvm "'&$CmdLine[1]&'""',@ScriptDir,@SW_HIDE)
		Else
			Run($nonportable_install_dir&"VirtualBox.exe")
		EndIf

		; Does not need to wait since it's a regular version of VirtualBox
		Exit
	EndIf
EndFunc
