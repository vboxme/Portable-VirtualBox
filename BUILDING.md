To build Portable-VirtualBox from source do the following:

### Prerequisites ###

Obtain and install the following

* AutoIt from http://www.autoitscript.com/site/autoit/downloads/ 
* 7zip from http://www.7-zip.org/
* Resource Hacker from http://www.angusj.com/resourcehacker/


## Obtaining the source code ##

Check out the source code from GitHub. For example by using git from the command line like this:

`git clone https://github.com/vboxme/Portable-VirtualBox.git`

This will make a new folder named "Portable-VirtualBox"


## Making a new version with the build script ##

Run the build.bat script. Run the build.bat script. A new version should appear in the `build\release` directory.


## Making a new version manually ##

### Compiling manually ###

1. Go to the Start menu and select All programs->AutoIt v3->Compile Script to .exe (x86)
2. Use the brows function to set:
* Source: Portable-VirtualBox\source\Portable-VirtualBox.au3
* Destination: Portable-VirtualBox\Portable-VirtualBox.exe
* Custom Icon: Portable-VirtualBox\source\VirtualBox.ico
3. Click convert

A new .exe file is created as Portable-VirtualBox.exe . This is Portable-VirtualBox and can be run from the Portable-VirtualBox folder.

### Releasing manually ###
To make a release you also need to do the following:

1. If you have run it in the Portable-VirtualBox folder delete the Portable-VirtualBox folder and do a new git clone and compile so its no junk in the data and app folders from previous runs
2. Go back to the Portable-VirtualBox folder
3. Right click on it and select 7zip->Add to archive
4. In the 7zip dialog select "Self extracting archive (SFX) and click "ok" 
5. This will make a new .exe file named Portable-VirtualBox.exe
6. Open the newly created Portable-VirtualBox.exe with Resource Hacker find the Icon Group->1->1033
7. Use the Replace resource function to replace it with the icon at Portable-VirtualBox\source\VirtualBox.ico
8. Save & exit