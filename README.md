Portable-VirtualBox Change bug
===================

Portable-VirtualBox is a free and open source software tool that lets you run any operating system from a USB stick without separate installation.

More info is available at http://www.vbox.me/

### Building ###

Please see here for information on how to build from source: [BUILDING](BUILDING.md).

VirtualBox 7.0.20 (released July 16 2024)

This is a maintenance release. The following items were fixed and/or added:

TPM: Fixed errors appearing the event viewer with Windows guests<br>
macOS Hosts: Fixed passing USB devices to the VM (bug #21218: https://www.virtualbox.org/ticket/21218)<br>
Audio: Fixed recording with HDA emulation after newer Windows 10 / 11 guests got rebooted<br>
USB: Fixed a deadlock in OHCI triggered when saving the current state of a VM or taking a snapshot (bug #22059: https://www.virtualbox.org/ticket/22059)<br>
Linux Guest and Host: Introduced initial support for OpenSuse 15.6 kernel<br>
Linux Guest and Host: Introduced initial support for RHEL 9.5 kernel (bug #22099: https://www.virtualbox.org/ticket/22099)<br>
Guest Additions: Shared Clipboard: Fixed issue when extra new lines were pasted when copying text between Win and X11 (bug #21716: https://www.virtualbox.org/ticket/21716 )<br>
UEFI Secure Boot: Add new Microsoft certificates to list for new VMs
