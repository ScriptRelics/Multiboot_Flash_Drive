



## Editing the Boot Menu

Lets fix the boot menu to automatically select a Kali Linix  

- I installed the kali-linux-2016.2-amd64 operating system but you may need to tweak some of the lines below for whatever you installed.  

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

We will need to edit another file `/multiboot/kali-linux-2016.2-amd64/isolinux/live.cfg`  



---


Here is an old script that I made to make the changes.

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



















Test your USB drive by booting into the Yumi Menu.  

---

[Back to the top. ⇧](../master/)  

  
```
```
  

[License](https://github.com/newCodez99/Using-Github/blob/master/LICENSE)

