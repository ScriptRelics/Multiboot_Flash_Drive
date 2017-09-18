



## Editing the Boot Menu

Lets fix the boot menu to automatically select a Kali Linix  

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
- You will need to modify `kali-linux-2016.2-amd64` to what you installed. 

Save the `syslinux.cfg` file.  





Test your USB drive by booting into the Yumi Menu.  


---

Now is a good time to run the install.sh script  
Open a terminal and mount the current USB drive

Type this in the Terminal.  
```sh
#Make a folder to mount to
mkdir /mnt/MYUSB1
#Mount the USB to a folder
mount /dev/sdb1 /mnt/MYUSB1
#Copy the shell file to the desktop
cp /mnt/MYUSB1/Kali-Persistence-setup.sh /root/Desktop/
#Run the file
. /root/DesktopKali-Persistence-setup.sh 
```
This will automatically fix the bootloader, set persistance and restart to a fully persistant Kali Linux.  

It will ask to restart.  

After restart connect to a network and run the script again  

It will update the system and restart the computer again. The update will take a very long time.  


### Manual

or do it manually  

