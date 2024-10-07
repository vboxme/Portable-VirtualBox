@echo off
@title Build Aut2Exe
cmd /c taskkill /im Portable-VirtualBox_x86.exe /f 2>nul
cmd /c taskkill /im Portable-VirtualBox_x64.exe /f 2>nul

rem Unseting user variables
set "aut2exe=source\Aut2Exe\Aut2exe_x64.exe"

rem Setting up the different folders used for building. %~dp0 is the folder of the build script itself (may not be the same as the working directory).
set "input_folder=%~dp0"
set "build_folder=%input_folder%build"


rem Find path for aut2exe
rem If the user supplied a aut2exe path use it
IF DEFINED "%aut2exe%" (
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

echo aut2exe path: %aut2exe%

rem Create build and release folders if needed.

rem Make a copy of the file for easy compression later.
rem xcopy /d /c /e /i "%input_folder%source\i_data" "%build_folder%\data\"
Mkdir "%build_folder%" 2>nul

rem Compile Portable-VirtualBox.
"%aut2exe%" /in "%input_folder%source\Portable-VirtualBox.au3" /out "%build_folder%\Portable-VirtualBox_x86.exe" /icon "%input_folder%source\VirtualBox.ico" /x86
"%aut2exe%" /in "%input_folder%source\Portable-VirtualBox.au3" /out "%build_folder%\Portable-VirtualBox_x64.exe" /icon "%input_folder%source\VirtualBox.ico" /x64

SET "_replace=%build_folder%"
SET "build_folder=%_replace:)=^)%"

echo ###############################################################################
for %%i in ("%build_folder%\Portable-VirtualBox_x64.exe") do (
echo Build new release as %build_folder%\Portable-VirtualBox_x64.exe
echo Size: %%~zi bytes
)
for %%i in ("%build_folder%\Portable-VirtualBox_x86-x64.exe") do (
echo Build new release as %build_folder%\Portable-VirtualBox_x86.exe
echo Size: %%~zi bytes
)
echo ###############################################################################

pause
