

## Editing the YUMI Boot Menu

Lets fix the YUMI boot menu to automatically select a Kali Linix  

- I installed the kali-linux-2017.1-amd64 operating system but you may need to tweak some of the lines below for whatever you installed.  

Open the USB flash drive and open the Multiboot folder  

Edit the `syslinux.cfg` file. `\multiboot\syslinux.cfg`  

about 19 lines down, the File will have a default menu option to boot from hard drive AND a system tools menu link that looks like this:
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

Lets open the menu where the Kali link is hiding and move it to the main menu by opening the other `syslinux.cfg` file in the menu folder. `\multiboot\menu\syslinux.cfg` 

Copy the kali menu link from `\multiboot\menu\syslinux.cfg` It should look like this:  
```
#start kali-linux-2017.1-amd64
LABEL kali-linux-2017.1-amd64
MENU LABEL kali-linux-2017.1-amd64
CONFIG /multiboot/kali-linux-2017.1-amd64/isolinux/isolinux.cfg
APPEND /multiboot/kali-linux-2017.1-amd64/isolinux
#end kali-linux-2017.1-amd64
```
Paste it ABOVE the boot to hard drive menu link in the main boot `\multiboot\syslinux.cfg` file.  
Add the MENU DEFAULT under it.  
Remove the Tools menu link.  

Now you should have a `\multiboot\syslinux.cfg` file with the menu items like this: 

```
#start kali-linux-2017.1-amd64
LABEL kali-linux-2017.1-amd64
MENU LABEL kali-linux-2017.1-amd64
CONFIG /multiboot/kali-linux-2017.1-amd64/isolinux/isolinux.cfg
APPEND /multiboot/kali-linux-2017.1-amd64/isolinux
#end kali-linux-2017.1-amd64
MENU DEFAULT

LABEL Boot from first Hard Drive
MENU LABEL Continue to Boot from ^First HD
KERNEL chain.c32
APPEND hd1
```

Save the file and you are finished with the YUMI boot menu.  

If you want to edit the background. Feel free to play with the 

## Editing the Kali Boot Menu

Now lets edit the Kali menu so it defaults to the `Kali Linux with Persistence` menu link.  

Open the USB flash drive and open the Multiboot follder > kali-linux-2017.1-amd64 > isolinux Folder. `\multiboot\kali-linux-2017.1-amd64\isolinux`  

We will need to edit the `live.cfg` file. `/multiboot/kali-linux-2016.2-amd64/isolinux/live.cfg`  

The first item will have the `menu default` in it. Move it down to the `label live-persistence` menu area. Like this:  

```
label live-persistence
    menu label ^Live USB Persistence              (check kali.org/prst)
    menu default
    linux /multiboot/kali-linux-2017.1-amd64/live/vmlinuz
    initrd /multiboot/kali-linux-2017.1-amd64/live/initrd.img
    append live-media-path=/multiboot/kali-linux-2017.1-amd64/live cdrom-detect/try-usb=true noprompt boot=live noconfig=sudo username=root hostname=kali persistence
```

Save the `live.cfg` file.  

If you want to edit the background. Feel free to play with the `splash.png` file `\multiboot\kali-linux-2017.1-amd64\isolinux\splash.png`  


Test your USB drive by booting into the Yumi Menu.  

---

---

### Old Stuff

Here is an old kali-linux-2016.2-amd64 script that I made to make the changes in linux.  


```sh

# Check if the script was run in root
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi



#Edit the Kali boot loader for quicker startups
KALIBOOTFILE="/lib/live/mount/persistence/sdb1/multiboot/kali-linux-2016.2-amd64/isolinux/live.cfg"
KALIBOOTCK=$(sed -n '3p' $KALIBOOTFILE |grep -c default)

echo "Checking Kali Bootscreen File" ;

#if [[ $KALIBOOTCK -ne 0 ]] ; then echo "Fixing the file" ; else echo "File is good" ; fi;
if [[ $KALIBOOTCK -ne 0 ]] ; then
	#Delete menu default
	sed -i '3d' $KALIBOOTFILE ;
	sleep 1 ;
	#Add default to persistence
	sed -i '/Live USB Persistence/a \
    menu default ' $KALIBOOTFILE ;  #this needs to be on a new line
fi ;

#Edit the YUMI boot loader for quicker startups
YUMIBOOTFILE="/lib/live/mount/persistence/sdb1/multiboot/syslinux.cfg"
echo "Checking YUMI Bootscreen File" ;
sleep 1
if [[ -r $YUMIBOOTFILE ]] ; then

	#Delete everything below line 19 to 50
	sed -i '19,50d' $YUMIBOOTFILE
	sleep 1
	#Put the edited info in the file

cat <<EOT >> $YUMIBOOTFILE


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
EOT

	sleep 1

else
	echo $YUMIBOOTFILE " - NOT FOUND! try mounting it again"
	sleep 1
	tree /mnt/MYUSB/

fi

```





















---

[Back to the top. ⇧](../master/How_to_edit_the_Yumi_Boot_Menu_for_faster_boot_ups.md#editing-the-boot-menu)  

  
```
```
  

[License](https://github.com/newCodez99/Using-Github/blob/master/LICENSE)

