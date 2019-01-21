. : Portable VirtualBox : . 

Description: Only start the Portable-VirtualBox.exe and all settings
             becomes automatically made. It must not be manually
             edited.

Features of starter:

- downloader and extractor for the installation file contain
- SplashScreen to start and end (with it one sees, which pass
  something) 
- HotKeys (STRG+1 bis STRG+6)
- HotKeys can be now self selected
- Tray-Menu (multilanguage)
- settings and languages saved in *.ini-files
- hide of the VM and of the manager in tray
- change the homefolder, start-VM, hotkeys and language with
  mouseclick (multilanguage)
- start of VirtualBox-Manager with parameter (Portable-VirtualBox.exe
  "VM")
- all absolute paths in the VirtualBox.xml are replaced automatically
  by relative paths
- examined to VirtaulBox-files exists
- a.o.f.

Note: VirtualBox needs at least main user rights, there 4 Services
      (VBoxDRV, VBoxUSBMon and if not already installs VBoxUSB,
      the VBoxNetFLT and sun_VboxNetFLT) to be furnished and
      VirtualBox must in " Ring-3" - Mode is initiated. The drivers
      the network become with snetcfg.exe (from the ms DDK 2003)
      merged. So that they are loaded, must into that Attitudes of
      Portable-VirtualBox, under the rider " NET" , this to be
      selected. For security, which one installs, must for the
      installation be agreed. After terminating Portable-VirtualBox
      the drivers become and files again removes! 

      Thus the NAT network functions and thus those shared-folders,
      must be installed the guest-extensions.

      Who wants to save some more place, knows all language files
      except that you which necessarily and the documentation delete 
      Again approx. 9MB saves. The language files are in the folder:
      app..\nls and the documentation in the folder: app..\doc.

      If VM runs you must press "Host-Key" (right CTRL-Key) in order
      to be able to use the Hotkeys. Since the focus lies then on the
      VM!

Network support: 1. to download of Portable-VirtualBox
                 2. unpack from Portable-VirtualBox
                 3. start from Portable-VirtualBox
                 4. attitudes open (Tray --> attitudes, CTRL+5)
                    --> rider Network (Tab) --> VirtualBox with
                    network support start --> memory (save)
                 5. terminate from Portable-VirtualBox
                 6. start from Portable-VirtualBox
                 7. driver installation agree
                 8. wait
                 9. selection of a VM and the network map to host
                    interfaces stop
                 10. attitudes make
                 11. FINISHED

Important: No files became of VirtualBox (https://www.virtualbox.org)
           modifies or otherwise changed. The files became only
           unpacked ones and with UPX (http://upx.sourceforge.net) or
           MPRESS (http://www.matcode.com/mpress.htm) packed, in
           order to save storage location!

Download and support:
http://www.vbox.me/

Languages of Launcher: English, German, Portuguese, Spanish, French,
                       Italian, Russian, Ukrainian, Japanese

Changelog of Starter:

Version 6.4.10
- Install file is now digitally signed for added security. Signer is
  "Open Source Developer, Runar Buvik", certificate issued by Certum Level III CA.

Version 6.4.9
- Ukrainian translation. Thank you Roman Kononenko
- Japanese translation. Thank you Kazuharu Inaba
- Commented progressbar
- Removed compression option

Version 6.4.8
- Fix to French and Spanish translation.
- Updated to 4.1.6
- Moved update mirror to configuration file (for testing)
- Polish translation (see Rev. #35)

Version 6.4.7
- Polish translation (first release)
- Fixed German and English translation
- Suggestions from Risky73 about bridged networking
- New hybrid mode that will run regular VirtualBox instead of portable one if found
- Many bug fixes

Version 6.4.5
- Fixed minor bugs on compress

Version 6.4.4
- Added Russian - thanks @SnakeSel
- Fixed minor bugs in the AutoIt-Script

Version 6.4.3
- Fixed minor bugs in the AutoIt-Script

Version 6.4.2
- Bug fixed of the automatic replacement of absolute paths in
  relative paths, in the VirtualBox.xml
- Bug fixed in the update system
- Cleanup AutoIt-Script
- Fixed minor bugs in the AutoIt-Script

Version 6.4.1
- Cleanup AutoIt-Script
- Fixed minor bugs in the AutoIt-Script

Version 6.4.0
- Language selection is now in first start
- Language files adapted
- Update dialogue in several languages now
- Bug fixed in the update system
- Fixed minor bugs in the AutoIt-Script

Version 6.3.1
- BugFix when manually extracting

Version 6.3.0
- References when starting renews
- UpDate-Dialogue adapted
- Cleanup AutoIt-Script
- Smaller errors in the AutoIt-Script eliminates

Version 6.2.9
- References when starting renews
- "7z.exe" and "upx.exe" updated
- Smaller errors in the AutoIt-Script eliminates

Version 6.2.8
- Cleanup AutoIt-Script
- Smaller errors in the AutoIt-Script eliminates

Version 6.2.7
- Errors in the UpDate-System eliminates

Version 6.2.6
- Online-Updates over menu capable of being turned off
- Language files adapted
- Reference for restart, with first use, for path mechanism
- Cleanup AutoIt-Script
- Smaller errors in the AutoIt-Script eliminates

Version 6.2.5
- BugFix of HotKeys
- Errors in the AutoIt Script eliminates

Version 6.2.4
- Language files adapted
- Tray-Menu now without CheckBox

Version 6.2.3
- UpDate-Dialogue adapted
- Errors in the AutoIt Script eliminates

Version 6.2.2
- Errors in the AutoIt-Script eliminates

Version 6.2.1
- Internet Update-System inserted
- "settings.ini" adapted
- "vboxinstall.ini" adapted
- Smaller errors in the AutoIt-Script eliminates

Version 6.2.0
- Update-System inserted
- "settings.ini" adapted
- "vboxinstall.ini" adapted
- "7z.exe" to the tools added
- Smaller errors in the AutoIt-Script eliminates

Version 6.1.0
- Remove SplashScreen 
- Remove Download-Info 
- Added Status-Info 
- Smaller errors in the AutoIt-Script eliminates

Version 6.0.0
- File structure changed
- "ExtensionPacks" are loaded and unpacked
- TEST USB-support
- AutoIt-Script adapted to new version
- Cleanup AutoIt-Script
- Smaller errors in the AutoIt-Script eliminates

Version 5.0.0
- File structure changed
- Full network support
- Cleanup AutoIt-Script
- Smaller errors in the AutoIt-Script eliminates

Version 4.2.1
- SplashScreen renews
- Renew task- and program-icon
- AutoIt-Script to Oracle adapted

Version 4.2.0
- AutoIt-Script adapted to new version

Version 4.1.5
- Errors with compress eliminated

Version 4.1.4
- Files which can be compressed updated

Version 4.1.3 
- Snapshot errors eliminates

Version 4.1.2
- AutoIt-Script adapted to new AutoIt-Version
- Smaller errors in the AutoIt-Script eliminates

Version 4.1.1
- Errors of the absolute paths with the Snapshots eliminates

Version 4.1.0
- Smaller changes with the files which can be compressed
- Removes old components (everything before VirtualBox v3.0.0)
- Smaller errors in the AutoIt-Script eliminates

Version 4.0.0
- SplashScreen, which is not it an official version of SUN
- Opening the license conditions of VirtualBox, over license button
- Selection, which version unpacked to become is
- Selection whether the files are to be compressed
- Selection whether the installation file is to be downloaded by portable VirtualBox
- Independent creation of the folders "app32" and/or " app64", depending upon selection
- GUI of the Entpackers into German and English
- Smaller errors in the AutoIt Script eliminates
- The launcher can use for all Win-Systems (32Bit, 64Bit or 32Bit/64Bit-Autoswitch)

Version 3.1.0
- BugFix when calling the network support

Version 3.0.9
- BugFix to finding out of os-architecture type

Version 3.0.8
- BugFix of HotKeys

Version 3.0.7
- Small BugFix in AutoIt-Script
- Languages updated
- AutoIt-Script adapted

Version 3.0.6
- BugFix if blanks are in the path and the network drivers are to be installed
- Languages updated

Version 3.0.5
- BugFix with providing the homelisting

Version 3.0.4
- BugFix in AutoIt-Script
- Languages updated (Russian removed)

Version 3.0.3
- BugFix when calling the x64-network support
- Small BugFix in AutoIt-Script

Version 3.0.2
- BugFix of SplashScreen, so that drivers to be installed can

Version 3.0.1
- BugFix of the automatic replacement of absolute paths in
  relative paths, in the VirtualBox.xml
- BugFix when calling the network support, is now also
  x86-compatible (snetcfg_x86.exe and snetcfg_x64.exe in
  "data\settings"-Folder)

Version 3.0.0
- Full network support integrates (this can be selected in the
  attitudes of portable VirtualBox, under NET)
  !!! The installation must be confirmed. After terminating the
  drivers, the services and all pertinent files are deleted!!!
- Languages updates 
- BugFixes in AutoIt-Script

Version 2.4.1
- Examine available its bound media, otherwise the data are deleted

Version 2.4.0
- BugFixes in AutoIt-Script

Version 2.3.9
- Change call of services
- BugFix in AutoIt-Script

Version 2.3.8
- BugFix of SnapShot-Paths, thus all absolute paths of
  SnapShots automatically by relative paths replaces
- Compatibility to older versions from VirtualBox and
  AutoIt receive

Version 2.3.7
- AutoIt-Script adapted, thus all absolute paths in the
  VirtualBox.xml automatically by relative paths replaces
- BugFix that is processed correctly the VirtualBox.xml by
  the launcher
- Settings of StartVM to new version of VirtualBox adapted
- BugFix in AutoIt-Script

Version 2.3.6
- AutoIt-Script adapted to new AutoIt-Version
- Small BugFixes in AutoIt-Script

Version 2.3.5
- AutoIt-Script adapted, thus all absolute paths in the
  VirtualBox.xml automatically by relative paths replaces

Version 2.3.4 
- Examine and copy available its files, for that Would drive out in
  the system file to lie must
- BugFix by copy the files in the AutoSwitch-Version

Version 2.3.3
- BugFix of VirtualBox-Manager, if blanks in the name of the VM

Version 2.3.2
- BugFix in HotKey-settings

Version 2.3.1
- BugFix in AutoIt-Script to the settings

Version 2.3.0
- Small BugFix and Cleaning of AutoIt-Script
- Only starters for all versions (32Bit-, 64Bit- and 32Bit/64Bit-AutoSwitch)
- Compatibility to older versions of launcher receive

Version 2.2.5
- BugFix in the USB-driver integration (hardware)

Version 2.2.4
- Small change by call of VBoxRT.dll

Version 2.2.3
- Update languages files
- Portable-VirtualBox now also on italian (thanks at @FSL from
  german-nlite.org-Forum)
- A common file for "VBoxGuestAdditions.iso" by 32Bit/64Bit-
  AutoSwitch-Version

Version 2.2.2
- BugFix by load of languagefiles

Version 2.2.1
- Launcher translates (with BabelFish) into French, Spanish,
  Portuguese, Russian
- Small BugFixes in AutoIt-Script

Version 2.2.0
- BugFix of VirtualBox-Manager
- Start of VirtualBox-Manager with parameter (Portable-VirtualBox.exe
  "VM")
- All absolute paths in the VirtualBox.xml are replaced automatically
  by relative paths
- Small BugFixes in AutoIt-Script

Version 2.1.3
- BugFix in tray-menu
- BugFix in HotKey-settings
- Small BugFixes in AutoIt-Script

Version 2.1.2
- BugFix in language-settings

Version 2.1.1
- BugFixes in HotKey-settings

Version 2.1.0
- HotKeys can be now self selected
- BugFixes

Version 2.0.0
- AutoIt-Script rewritten
- New settings-menu
- Set language about *.ini (multilanguages-support of launcher)
- BugFixes

Version 1.4.0
- AutoIt-Script rewritten
- Drivers are loaded now all with "Windows-Boardmeans"
- HotKeys disconnectible

Version 1.3.7
- BugFix of services, rename this because there is complications when
  VirtualBox is installed on hostsystem
- Small BugFixes in AutoIt-Script

Version 1.3.6
- Only one instance can be started by VirtualBox (if VirtualBox is
  already loaded on this instance the focus is put and gotten into
  the foreground)
- UAC-signification for Windows Vista
- Definite exit instruction into the AutoIt-Script in-maintained

Version 1.3.5
- BugFix with VirtualBox-Managers use
- BugFix with loading and call the service
- Deletion the unnecessary service in the AutoIt Script

Version 1.3.4
- BugFix to settings in English
- Text for the selection of the homelisting and VirtualBox-Managers
  adapted

Version 1.3.3
- Icon refreshed
- BugFix to load driver

Version 1.3.2
- BugFix by the focus of radio buttons (if a homefolder or a VM is
  selected, jumps the focus now automatically on the correct radio
  button)

Version 1.3.1
- BugFix with the selection of a VM with the VirtualBox-Manager

Version 1.3
- Homefolder and VirtualBox-Manager VM can now also simply with the
  mouse selected or by hand to be registered
- Examination whether VirtualBox-Files are present, is now more
  exactly

Version 1.2.1
- BugFix in the call of the VirtualBox-Manager

Version 1.2
- Starts also without SplashScreen (simple text box indicated)
- "Batch file far away and through settings.ini" replaces (with to be
  missing one provides automatically)
- New Hotkeys (STRG+1 to STRG+7)
- Hotkeys now aligned
- Menu extends, because of the options for the homefolder and the
  VirtualBox-Manager
- Can be configured to home listing and VirtualBox Manger over GUI
  (STRG+5: other one Homelisting or DEFAULT; STRG+6: VirtualBox
  managers use or DEFAULT)
- Menu recognizes automatically the language of the OS (German:
  Germany, Austria, Switzerland; English: everything other countries)
- Start examined with whether the VirtualBox-Files are present (with
  appears one is missing Error message and the start broken off)

Version 1.1
- SplashScreen when starting and terminate (with it one sees, which
  pass something)
- Hotkeys (STRG+1 to STRG+5)
- right mouse click on the Tray icon for options
- Minimize to the Tray

Version 1.0
- All redundant files were removed and integrated into the AutoIt-
  Script
- No files are copied
- The services for VirtualBox are started by AutoIt

Much fun

Micha (michaelm_007)
