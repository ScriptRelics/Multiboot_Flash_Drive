# [Install with Yumi](https://www.pendrivelinux.com/yumi-multiboot-usb-creator/)  

YUMI works much like Universal USB Installer, except it can be used to add more than one distribution to run Live from your Thumb Drive.

Download the portable [Yumi](https://www.pendrivelinux.com/yumi-multiboot-usb-creator/) installer.

Open up Yumi.

![Yumi](https://www.pendrivelinux.com/wp-content/uploads/YUMI-Multiboot-USB-Creator.png "Yumi")

### Clean Install 

Select your USB device. Step 1  
- Double and triple check you have the right USB selected.  

##### Optional reformat:  
You might want to reformat the drive first. Here is how:  

Select: "Fat32 format K: (Wipes Drive)"  

- Your letter dive may be different.  
- Selecting it will change to "We Will Fat32 Format K:"  

>Why Fat32 and not NTFS?  
>
>Microsoft created NTFS and it will not be able to be used for Linux operating systems. Plus, there’s really no reason to use NTFS on USB sticks and SD cards unless you really need support for files over 4GB in size.  
>
>Things to keep in mind are FAT32 only supports individual files up to 4GB in size and volumes up to 2TB in size. The file system corruption can happen much easier. FAT32 doesn’t support file permissions.  


Select a Distribution. Step 2  
- Kali (Penetration Testing). It can be [downloaded Here at kali.org](https://www.kali.org/downloads/).


Browse and select the ISO. Step 3  

Click Create.  
- Accept your USB fate and click yes on the warning popup.  

Wait...  
- 7zip and other popups may appear  
- The bigger the drive, the longer the format will be. I waited 25 min for my 60g flash drive. 

When you see "All Finsihed, Process is Complete!" Click Next.  

You will be promped "Would you like to add more ISOs/Distros Now?" 
- Click Yes if you want to add another Operating system. 
- Click No if you are finished.  
Click Finish.  

From here you can eject your USB and/or boot into your new portable operating system.

### Editing the Boot Menu

You can edit the boot menu to change the auto start time or the selected system.

![Yumi Boot Menu](https://www.pendrivelinux.com/wp-content/uploads/YUMI-Boot-Menu.png "Yumi Boot Menu")

Open the USB flash drive and open the Multiboot folder
Edit the syslinux.cfg file

Change: 
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
- You will need to modify this you what you installed. 


  
```
```
  

[License](https://github.com/newCodez99/Using-Github/blob/master/LICENSE)
