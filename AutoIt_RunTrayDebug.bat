@echo off
@title Run AutoIt Source Tray Debug
@chcp 65001>Nul

set "AutoIt3=source\AutoIt3.exe"

rem Setting up the different folders used for building. %~dp0 is the folder of the build script itself (may not be the same as the working directory).
set "input_folder=%~dp0"
set "build_folder=%input_folder%build"


rem Find path for AutoIt3
rem If the user supplied a AutoIt3 path use it
IF DEFINED "%AutoIt3%" (
	echo Using user defind path to AutoIt3
	goto done_AutoIt3
)

rem Try to find the AutoIt3 path.
set "PPATH=%ProgramFiles%\AutoIt3\AutoIt3.exe"
IF exist "%PPATH%" (
    set "AutoIt3=%PPATH%"
	goto done_AutoIt3
) 

set "PPATH=%ProgramFiles(x86)%\AutoIt3\AutoIt3.exe"
IF exist "%PPATH%" (
    set "AutoIt3=%PPATH%"
	goto done_AutoIt3
) 

:done_AutoIt3
IF not exist "%AutoIt3%" (
    echo Can't locate AutoIt. Is it installed? Pleas set the AutoIt3 variable if it is installed in a nonstandard path.
    EXIT /B
)

:m1
echo AutoIt3 path: %AutoIt3%
echo.&
Tasklist /FI "IMAGENAME eq AutoIt3.exe" 2>Nul|findstr "= # AutoIt3" && echo.&

echo Enter the number:
echo 1 -^>^ Run script execution
echo 2 -^>^ Exit or close console to cancel
echo.&
Set /p choice="Write a number to continue: "
if not defined choice cls&&goto m1
if "%choice%"=="1" (
cls
goto Start
)
if "%choice%"=="2" (
exit
)

:Start
echo Wait for the Portable-VirtualBox source code to run,
echo all data is in folder source
echo.&
echo You can minimize the console if you need to restart it after closing
echo Portable-VirtualBox, you will return to the menu, if the console is
echo no longer needed, you can close it manually

TaskList /FI "ImageName EQ AutoIt3.exe"|Find /I "AutoIt3">nul||(
rem Launch Portable-VirtualBox.
start "" "%AutoIt3%" "%input_folder%source\Portable-VirtualBox.au3"
timeout /t 10
)

cls
goto m1