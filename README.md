22.10.2024 If you have an old language folder, Delete the data\language folder as the languages ​​have been partially changed.
Disable message center notifications and screen capture messages VirtualBoxVM.exe default settings directory:<br>
Portable-VirtualBox\\.VirtualBox\VirtualBox.xml<br>
Change or add before launch <ExtraDataItem name=\"GUI/SuppressMessages\" value=\"all\"/> sample:<br><br>
<ExtraData\><br>
<ExtraDataItem name=\"GUI/GuestControl/FileManagerVisiblePanel\" value=\"LogPanel\"/><br>
<ExtraDataItem name=\"GUI/LastItemSelected\" value=\"m=2bd3571f-97f7-4297-b779-2b6f3d9c5ae0\"/><br>
<ExtraDataItem name=\"GUI/LastWindowPosition\" value=\"121,139,848,438\"/><br>
<ExtraDataItem name=\"GUI/SessionInformationDialogGeometry\" value=\"296,140,512,360\"/><br>
<ExtraDataItem name=\"GUI/SuppressMessages\" value=\"all\"/><br>
<ExtraDataItem name=\"GUI/Tools/LastItemsSelected\" value=\"Welcome,Details\"/><br>
<\/ExtraData><br><br>
Save the VirtualBox.xml file

Portable-VirtualBox Change bug
===================

Portable-VirtualBox is a free and open source software tool that lets you run any operating system from a USB stick without separate installation.

More info is available at http://www.vbox.me/

### Building ###

Please see here for information on how to build from source: [BUILDING](BUILDING.md).

### Changelog for VirtualBox ###

<strong>VirtualBox 7.0.22</strong> (released October 15 2024)<br /><br />
This is a maintenance release. The following items were fixed and/or added:
</p>
<ul><li>GUI: Fixed deletion of VMs with unattended install related files, no longer leave them behind causing trouble with creating a new VM with the same name (bug <a class="closed ticket" href="https://www.virtualbox.org/ticket/21331" title="#21331: defect: Delete of a VM does not delete unattended files, so can't recreate VM (closed: fixed)">#21331</a>)
</li><li>GUI: Updated Italian, Greek, Georgian, Turkish and Indonesian translations
</li><li>VMSVGA: Improved flickering, black screen and other screen update issues with recent Linux kernels (bug <a class="accepted ticket" href="https://www.virtualbox.org/ticket/21955" title="#21955: defect: Heavy screen flickering VirtualBox 6.1.48 / 7.0.12 Ubuntu Wayland ... (accepted)">#21955</a>)
</li><li>TPM: Fixed multiple issues with TPM deployment with Windows 10/11 VMs
</li><li>3D: Improve accuracy of 3D capability reporting, limit it to what the host can handle
</li><li>API: Suppress logging of "Screenshot is not possible" errors when the VGA config is invalid, avoiding user confusion
</li><li>API: Fixed NVRAM file handling when taking snapshots
</li><li>API: Fixed NVRAM file deletion for VMs using BIOS firmware
</li><li>API: Fixed rare hangs when API objects are uninitialized concurrently
</li><li>Windows host: Fixed system DLL size checking which failed with Windows 11 24H2 and recent Insider Preview builds (bug <a class="closed ticket" href="https://www.virtualbox.org/ticket/22162" title="#22162: defect: WIndows hosts based on W11 24H2 cannot start headless or detachable ... (closed: fixed)">#22162</a>)
</li></ul>
