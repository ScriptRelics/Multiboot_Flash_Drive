# How to install and configure a multiboot USB flash drive with Kali Linux

## Formating the USB Drive for a clean Kali install with persistance.

If you want to have persistence for your Kali Linux then you are going to need to format the drive with an extra partition.  

A partition tool like [MiniTool Partition Wizard](https://www.partitionwizard.com/download.html) (Windows) or gparted (Linux) will be needed to create the persistence partition.  

Delete and format the entire USB flash drive to `primary` in the `fat32` file system to wipe it clean.  

- If you are formating in Windows, make sure the partitions are primary and NOT logical. 

<details>  
    <summary> Why Fat32 and not NTFS?  </summary>  
  <p>Microsoft created NTFS and it will not be able to be used for Linux operating systems. Plus, there’s really no reason to use NTFS on USB sticks and SD cards unless you really need support for files over 4GB in size.  

Things to keep in mind are FAT32 only supports individual files up to 4GB in size and volumes up to 2TB in size. The file system corruption can happen much easier. FAT32 doesn’t support file permissions.  

  </p>  
</details>  

- I named mine `Multiboot` but this is optional because Yumi will do this for you automatically later.  


Resize the main partition to allow a new partition with at least 6GB of space. 
- Out of the 60BG my USB drive had available, I gave my persistence drive 18GB.  

Format the new partition in the ext4 file system and name it `persistence`  
- The new partition is case sensitive, use lower case.  

You should now have a USB flash drive with 2 partitions, one named persistence in the ext4 file format.  

- The bigger the drive, the longer the format will be. I waited 25 min for my 60g USB flash drive.  


## [Install with Yumi](https://www.pendrivelinux.com/yumi-multiboot-usb-creator/)  

YUMI works much like the [Universal USB Installer](https://www.pendrivelinux.com/universal-usb-installer-easy-as-1-2-3/), except it can be used to add more than one distribution to run Live from your Thumb Drive.

Download the portable [Yumi](https://www.pendrivelinux.com/yumi-multiboot-usb-creator/) installer.

Open up Yumi and agree to the license agreement.

![Yumi](https://www.pendrivelinux.com/wp-content/uploads/YUMI-Multiboot-USB-Creator.png "Yumi")

### Clean Install 

Select your USB device. Step 1 
- Double and triple check you have the right USB selected.  

Select a Distribution. Step 2 
- Kali (Penetration Testing). It can be [downloaded Here at kali.org](https://www.kali.org/downloads/).

Browse and select the ISO. Step 3  

Click Create.  
- Accept your USB fate and click yes on the warning pop-up.  

Wait for Yumi to finish... 
- 7zip and other pop-ups may appear  

When you see `All Finished, Process is Complete!` Click Next.  

You will be prompted `Would you like to add more ISOs/Distros Now?` 
- Click Yes if you want to add another Operating system. 
- Click No if you are finished.  

Click Finish.  

From here you can eject your USB and/or boot into your new portable operating system. 

- Make sure the computer is set to boot from USB. Check the BIOS.  

When the menu pops up, move the selection down to Select the `System Tools` menu  

Select the Kali-Linux Operating System  

This will take you to the Kali Menu. Select `Live USB Persistence` 

- This will bring you to the Kali Desktop.  

### Setting Persistence

Finish the setup by mounting the persistence partition and join it to the conf file.

First, find out what the USB device is called. Open the terminal and type:

```
fdisk -l
```

Look for the Multiboot USB device. My device was named sdb2 for this example. `/dev/sdb2`  
- Your device might be labeled differently. Adjust the code below.

In the terminal and type:  

```sh
#Make a directory to mount to.  
mkdir -p /mnt/MYUSB/
#Mount to the new directory.  
mount /dev/sdb2 /mnt/MYUSB
#Make the file with the needed info.  
echo "/ union" > /mnt/MYUSB/persistence.conf
#Unmount the drive.  
umount /dev/sdb2 /mnt/MYUSB
#Restart the system
systemctl reboot  
```

You are done, but I would suggest that you update the system.  

```sh
#clean then update then upgrade the updates
apt-get clean && apt-get -y update && apt-get -y upgrade  
#clean then clean some more then remove junk - *Hashtag* CleanFreak
apt-get clean && apt -y autoclean && apt -y autoremove
```
- This might take a LONG time.  

Enjoy Kali. Check out my [optional edits and tweaks HERE.](https://github.com/newCodez99/Multiboot_Flash_Drive).  

Need more help? [Look at the official Kali.org Linux guide.](https://docs.kali.org/downloading/kali-linux-live-usb-persistence)

Go [back to the Readme.](https://github.com/newCodez99/Multiboot_Flash_Drive#how-to-install-a-kali-operating-system-on-a-usb-drive-and-tweak-it)

[Back to the top. ⇧](../master/How_To_Install_And_Configure_A_Multiboot_Flash_Drive.md#how-to-install-and-configure-a-multiboot-usb-flash-drive-with-kali-linux)  

  
```
```
  

[License](https://github.com/newCodez99/Using-Github/blob/master/LICENSE)
