@echo off

rem Unseting user variables
set "aut2exe=source\Aut2Exe\Aut2exe_x64.exe"
set "sevenzip=data\tools\7za.exe"

rem User-defined variables. You may have to change its values to correspond to your system and remove the "rem" statement in front of it.
rem set "aut2exe=C:\Program Files (x86)\AutoIt3\Aut2Exe\aut2exe.exe"
rem set "sevenzip=C:\Program Files\7-Zip\7z.exe"
rem End of user-defined variables.



rem Setting up the different folders used for building. %~dp0 is the folder of the build script itself (may not be the same as the working directory).
set "input_folder=%~dp0"
set "build_folder=%input_folder%build"


rem Find path for aut2exe
rem If the user supplied a aut2exe path use it
IF DEFINED aut2exe (
	echo Using user defind path to aut2exe
	goto done_aut2exe
)

rem Try to find the aut2exe path.
set "PPATH=%ProgramFiles%\AutoIt3\Aut2Exe\aut2exe.exe"
IF exist "%PPATH%" (
    set "aut2exe=%PPATH%"
	goto done_aut2exe
) 

set "PPATH=%ProgramFiles(x86)%\AutoIt3\Aut2Exe\aut2exe.exe"
IF exist "%PPATH%" (
    set "aut2exe=%PPATH%"
	goto done_aut2exe
) 

:done_aut2exe
IF not exist "%aut2exe%" (
    echo Can't locate AutoIt. Is it installed? Pleas set the aut2exe variable if it is installed in a nonstandard path.
    EXIT /B
)


rem Find path for sevenzip
rem If the user supplied a sevenzip path use it
IF DEFINED sevenzip (
	echo Using user defind path to sevenzip
	goto done_sevenzip
)

rem Try to find the sevenzip path.
set "PPATH=%ProgramFiles%\7-Zip\7z.exe"
IF exist "%PPATH%" (
    set "sevenzip=%PPATH%"
	goto done_sevenzip
) 

set "PPATH=%ProgramFiles(x86)%\7-Zip\7z.exe"
IF exist "%PPATH%" (
    set "sevenzip=%PPATH%"
	goto done_sevenzip
) 

:done_sevenzip
IF not exist "%sevenzip%" (
    echo Can't locate 7-Zip. Is it installed? Pleas set the sevenzip variable if it is installed in a nonstandard path.
    EXIT /B
)

echo aut2exe path: %aut2exe%
echo sevenzip path: %sevenzip%

rem Create build and release folders if needed.

rem Make a copy of the file for easy compression later.
xcopy /d /c /e /i "%input_folder%data" "%build_folder%\data\"

rem Compile Portable-VirtualBox.
"%aut2exe%" /in "%input_folder%source\Portable-VirtualBox.au3" /out "%build_folder%\Portable-VirtualBox_x86.exe" /icon "%input_folder%source\VirtualBox.ico" /x86
"%aut2exe%" /in "%input_folder%source\Portable-VirtualBox.au3" /out "%build_folder%\Portable-VirtualBox_x64.exe" /icon "%input_folder%source\VirtualBox.ico" /x64

echo ###############################################################################
for %%i in ("%build_folder%\Portable-VirtualBox_x64.exe") do (
echo Build new release as %build_folder%\Portable-VirtualBox_x64.exe
echo Size: %%~zi bytes
)
for %%i in ("%build_folder%\Portable-VirtualBox_x86.exe") do (
echo Build new release as %build_folder%\Portable-VirtualBox_x86.exe
echo Size: %%~zi bytes
)
echo ###############################################################################

pause
