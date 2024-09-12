On VirtualBox versions ver. 7 and above
Disable message center notifications and screen capture messages VirtualBoxVM.exe default settings directory:
Portable-VirtualBox\\.VirtualBox\VirtualBox.xml
Edit or add <ExtraDataItem name=\"GUI/SuppressMessages\" value=\"all\"/> sample:<br><br>
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

<strong>VirtualBox 7.1.0</strong> (released 11.09.2024)

This is a major update. The following new features were added:

<ul><li>GUI: Modernized look and feel, offering a selection between Basic and Experienced user level with reduced or full UI functionality
</li><li>OCI Integration: Performance dashboard now shows resource usage for cloud VMs
</li><li>OCI Integration: Clone compute instances
</li><li>OCI Integration: Reset compute instances
</li><li>Oracle <a class="wiki" href="/wiki/VirtualBox">VirtualBox</a> Extension Pack: Update to the PUEL license, removing the evaluation option. For evaluation use of the Extension Pack, please download it from the Oracle Software Delivery Cloud
</li><li>VRDE: If user does not set up TLS with custom certificates, enable it with self-signed certificate, including issuing a new one before the old one expires
</li><li>NAT: New engine with IPv6 support
</li><li>macOS/Arm host: Arm virtualization for Linux and BSD VMs
</li><li>Linux host and guest: Added Wayland support for Clipboard sharing (bug <a class="new ticket" href="/ticket/20808" title="#20808: defect: shared clipboard does not work with Wayland (new)">#20808</a>)
</li><li>Shared Clipboard: Added initial support for transferring files on Linux and Windows hosts / guests. This requires the 7.1 Guest Additions to be installed. See User Guide for known limitations
</li><li>Screen Recording: Significant performance improvements for the encoding pipeline, resulting in less CPU usage while recording is active. This requires 7.1 Guest Additions to be installed on Windows guests
</li></ul><br>
UEFI Secure Boot: Add new Microsoft certificates to list for new VMs
