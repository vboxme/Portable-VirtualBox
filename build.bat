@echo off       

rem Unseting user variables
set "aut2exe="
set "sevenzip="
set "reshack="
set "signtool="

rem User-defined variables. You may have to change its values to correspond to your system and remove the "rem" statement in front of it.
rem set "aut2exe=C:\Program Files (x86)\AutoIt3\Aut2Exe\aut2exe.exe"
rem set "sevenzip=C:\Program Files\7-Zip\7z.exe"
rem set "reshack=C:\Program Files (x86)\Resource Hacker\ResourceHacker.exe"
rem End of user-defined variables.



rem Setting up the different folders used for building. %~dp0 is the folder of the build script itself (may not be the same as the working directory).
set "input_folder=%~dp0"
set "build_folder=%input_folder%\build\source"
set "release_folder=%input_folder%\build\release"
set "output_name=Portable-VirtualBox_current.exe"


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


rem Find path for reshack
rem If the user supplied a reshack path use it
IF DEFINED reshack (
	echo Using user defind path to reshack
	goto done_reshack
)

rem Try to find the reshack path.
set "PPATH=%ProgramFiles%\Resource Hacker\reshacker.exe"
IF exist "%PPATH%" (
    set "reshack=%PPATH%"
	goto done_reshack
) 

set "PPATH=%ProgramFiles(x86)%\Resource Hacker\reshacker.exe"
IF exist "%PPATH%" (
    set "reshack=%PPATH%"
	goto done_reshack
) 

set "PPATH=%ProgramFiles%\Resource Hacker\ResourceHacker.exe"
IF exist "%PPATH%" (
    set "reshack=%PPATH%"
	goto done_reshack
) 

set "PPATH=%ProgramFiles(x86)%\Resource Hacker\ResourceHacker.exe"
IF exist "%PPATH%" (
    set "reshack=%PPATH%"
	goto done_reshack
)

:done_reshack
IF not exist "%reshack%" (
    echo Can't locate Reshack. Is it installed? Pleas set the reshack variable if it is installed in a nonstandard path.
    EXIT /B
)



rem Find path for signtool
rem If the user supplied a signtool path use it
IF DEFINED signtool (
	echo Using user defind path to signtool
	goto done_signtool
)

rem Try to find the signtool path.
set "PPATH=%ProgramFiles(x86)%\Windows Kits\8.1\bin\x64\signtool.exe"
IF exist "%PPATH%" (
    set "signtool=%PPATH%"
	goto done_signtool
) 

set "PPATH=%ProgramFiles(x86)%\Microsoft SDKs\Windows\v7.0A\Bin\signtool.exe"
IF exist "%PPATH%" (
    set "signtool=%PPATH%"
	goto done_signtool
) 



:done_signtool
IF "%~1"=="-s" IF not exist "%signtool%" (
    echo Can't locate signtool. Is it installed? Pleas set the signtool variable if it is installed in a nonstandard path.
    EXIT /B
)



echo aut2exe path: %aut2exe%
echo sevenzip path: %sevenzip%
echo reshack path: %reshack%
echo signtool path: %signtool%

rem Remove any old files in the build directory.
rmdir /s /q %build_folder%\Portable-VirtualBox

rem Create build and release folders if needed.
if not exist "%build_folder%\Portable-VirtualBox" md "%build_folder%\Portable-VirtualBox"
if not exist "%release_folder%" md "%release_folder%"

rem Make a copy of the file for easy compression later.
xcopy /i /e "%input_folder%data" "%build_folder%\Portable-VirtualBox\data\"
xcopy /i /e "%input_folder%source" "%build_folder%\Portable-VirtualBox\source\"
xcopy "%input_folder%LiesMich.txt" "%build_folder%\Portable-VirtualBox\"
xcopy "%input_folder%ReadMe.txt"  "%build_folder%\Portable-VirtualBox\"

rem Compile Portable-VirtualBox.
"%aut2exe%" /in "%build_folder%\Portable-VirtualBox\source\Portable-VirtualBox.au3" /out "%build_folder%\Portable-VirtualBox\Portable-VirtualBox.exe" /icon "%build_folder%\Portable-VirtualBox\source\VirtualBox.ico" /x86
if not exist "%build_folder%\Portable-VirtualBox\Portable-VirtualBox.exe" (
	echo Failed to build exe. No .exe file was produced
	EXIT /B
)

rem Sign the main .exe file if run with -s
IF "%~1"=="-s" (
	echo "Signing main .exe file"
	"%signtool%" sign /a "%build_folder%\Portable-VirtualBox\Portable-VirtualBox.exe"
)

rem Make a release by packing the exe, data and source code into a self-extracting archive.
pushd %build_folder%
"%sevenzip%" a -r -x!.git -sfx7z.sfx "%release_folder%\Portable-VirtualBox.tmp" "Portable-VirtualBox"
popd

rem Change the icon on the self-extracting archive.
"%reshack%" -addoverwrite "%release_folder%\Portable-VirtualBox.tmp", "%release_folder%\%output_name%", "%build_folder%\Portable-VirtualBox\source\VirtualBox.ico",ICONGROUP,1,1033

del /q "%release_folder%\Portable-VirtualBox.tmp"

rem Signing the self extracting .exe file if run with -s
IF "%~1"=="-s" (
	echo "Signing self extracting .exe file"
	"%signtool%" sign /a "%release_folder%\%output_name%"
)

echo ###############################################################################
echo Build new release as %release_folder%\%output_name%
echo ###############################################################################

pause