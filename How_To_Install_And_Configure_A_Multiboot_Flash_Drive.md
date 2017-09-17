How to install and configure a multiboot flash drive with Kali Linux

### Formating the Drive for a clean install and persistance.

If you want to have persistence for your Kali Linux then you are going to need to format the drive with an extra partition.

A partition tool like [MiniTool Partition Wizard](https://www.partitionwizard.com/download.html) (Windows) or gparted (Linux) will be needed to create the persistence partition.  

Delete and format the entire USB flash drive in the fat32 file system to wipe it clean. I named mine `Multiboot` but this is optional.

<details>
  <summary>Why Fat32 and not NTFS?  </summary>
  <p>Microsoft created NTFS and it will not be able to be used for Linux operating systems. Plus, there’s really no reason to use NTFS on USB sticks and SD cards unless you really need support for files over 4GB in size.  

Things to keep in mind are FAT32 only supports individual files up to 4GB in size and volumes up to 2TB in size. The file system corruption can happen much easier. FAT32 doesn’t support file permissions.  
  </p>
</details>

Resize the main partition to allow another partition with at least 4GB of space. Out of the 60BG available, I gave my persistence drive 18GB.  
Format the new partition in the ext4 file system and name it `persistence`.  
- The new partition is case sensitive, use lower case.  
You should now have a USB flash drive with 2 partitions, one named persistence in the ext4 file format.  

- The bigger the drive, the longer the format will be. I waited 25 min for my 60g flash drive.


# [Install with Yumi](https://www.pendrivelinux.com/yumi-multiboot-usb-creator/)  

YUMI works much like the [Universal USB Installer](https://www.pendrivelinux.com/universal-usb-installer-easy-as-1-2-3/), except it can be used to add more than one distribution to run Live from your Thumb Drive.

Download the portable [Yumi](https://www.pendrivelinux.com/yumi-multiboot-usb-creator/) installer.

Open up Yumi.

![Yumi](https://www.pendrivelinux.com/wp-content/uploads/YUMI-Multiboot-USB-Creator.png "Yumi")

### Clean Install 

Select your USB device. Step 1  
- Double and triple check you have the right USB selected.  

Select a Distribution. Step 2  
- Kali (Penetration Testing). It can be [downloaded Here at kali.org](https://www.kali.org/downloads/).


Browse and select the ISO. Step 3  

Click Create.  
- Accept your USB fate and click yes on the warning popup.  

Wait for Yumi to finish...  
- 7zip and other popups may appear  

When you see "All Finsihed, Process is Complete!" Click Next.  

You will be promped "Would you like to add more ISOs/Distros Now?" 
- Click Yes if you want to add another Operating system. 
- Click No if you are finished.  

Click Finish.  

From here you can eject your USB and/or boot into your new portable operating system.

### Manually Editing the Boot Menu

You can edit the boot menu to change the auto start time or the selected system. There is also a scrip that can do this for you, [HERE]().

![Yumi Boot Menu](https://www.pendrivelinux.com/wp-content/uploads/YUMI-Boot-Menu.png "Yumi Boot Menu")

Open the USB flash drive and open the Multiboot folder  
Edit the `syslinux.cfg` file.  

about 19 lines into the file, Change:  
```
LABEL Boot from first Hard Drive
MENU LABEL Continue to Boot from ^First HD (default)
KERNEL chain.c32
APPEND hd1
MENU DEFAULT

label System Tools
menu label System Tools ->
MENU INDENT 1
CONFIG /multiboot/menu/system.cfg
```
to
```
LABEL Boot from first Hard Drive
MENU LABEL Continue to Boot from ^First HD
KERNEL chain.c32
APPEND hd1

#start kali-linux-2016.2-amd64
LABEL kali-linux-2016.2-amd64
MENU LABEL kali-linux-2016.2-amd64
CONFIG /multiboot/kali-linux-2016.2-amd64/isolinux/isolinux.cfg
APPEND /multiboot/kali-linux-2016.2-amd64/isolinux
#end kali-linux-2016.2-amd64
MENU DEFAULT
```
This will select the kali-linux-2016.2-amd64 that I installed earlier.
- You will need to modify this to what you installed. 

Save the `syslinux.cfg` file.  

Test your USB drive by booting into the Yumi Menu.  


  
```
```
  

[License](https://github.com/newCodez99/Using-Github/blob/master/LICENSE)
