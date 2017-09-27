

## My Tweaks and must have programs for Kali Linux

So you have a fresh persistence enabled Kali Linux installed on your USD flash drive. Lets tweak it a little.  

### Setting Changes

Lets open the main settings menu by selecting the `down arrow` in the top right hand corner of the screen.  

Select the `Settings` icon to open the All Settings window.  

#### Screen Saver

The very first thing you should do is turn off the screen saver.  
- We don't want the screen saver going off when we are updating things. 

Select the `Power` menu  

Change the `Blank Screen` from 5 minutes to `Never`  

Go back to the All Settings window and select the `Privacy` icon.  

Change Screen Lock from ON to `OFF`  
- This will open another menu to select `Automatic Screen Lock` to off.  

Close the All Settings Windows.  

### Apperance Tweaks

Lets change more settings in another settings area.  

From the Desktop, open to the Tweaks setting window by clicking on the `Tweak Tool` on docked bar.  

go to the `Appearance` tab  

Change the GTK+ to `Blackbird` for the Dark theme.  

### Terminal Tweaks

Open the Terminal. Lets change the information, color, and look of the terminal by configuring the Bash prompt.  To do this we will need to edit the `.bashrc` file. `/root/.bashrc`  
The .bashrc file is a shell script that runs every time you open a new shell.  

Try out my personal [.bashrc file that can be viewed HERE.](../master/.bashrc)  

You are going to want to download it and overwrite your .bashrc file. 

```sh
#change directory to the Desktop - A good place to download to.
cd /root/Desktop
#Download the file
wget https://raw.githubusercontent.com/newCodez99/Multiboot_Flash_Drive/master/.bashrc
#make a backup of the original .bashrc file just in case you have the willys
cp /root/.bashrc bashrc_backup
#Paste our new .bashrc to the root folder
cp .bashrc /root/.bashrc
#restart bash
source ~/.bashrc
```
You now have a TON of handy aliases and an updated command line.


### New Password

Now change the root password. You have a powerful weapon, lets change the default password so it cant be used against us.  

Open the terminal and type:

```sh
passwd
```

Set your new password.  

### Netwrok changes

By default the network interfaces are down. Lets turn them on.

```sh
# Add eth0 and wlan0 to interfaces for autostart
cat > /etc/network/interfaces <<EOF
auto lo
iface lo inet loopback
allow-hotplug eth0
iface eth0 inet dhcp
allow-hotplug wlan0
iface wlan0 inet dhcp
iface default inet dhcp
EOF
```

Network Manager needs to manage the networks now that you added them to the interfaces file  

```sh
# Set Network Manager management to true
sed -i ' s/managed=false/managed=true/ ' /etc/NetworkManager/NetworkManager.conf
service network-manager restart
```

And just for fun, Lets enable auto MacChanger.  

Edit the `/etc/default/macchanger` file and change the `ENABLE_ON_POST_UP_DOWN=false` to `true`  

```sh
# Enable the auto Macchanger
sed -i ' s/ENABLE_ON_POST_UP_DOWN=false/ENABLE_ON_POST_UP_DOWN=true/ ' /etc/default/macchanger
```


### Firefox extensions  

Lets add some Firefox extensions.  
- You will need to be connected the the internet first.  

```sh
start firefox --new-tab https://extensions.gnome.org/extension/1031/topicons/
firefox --new-tab https://extensions.gnome.org/extension/72/recent-items/
firefox --new-tab https://extensions.gnome.org/extension/779/clipboard-indicator/
```



### Update and Upgrade  

Before installing any programs, Update.  

- This might take some time.  
- You should restart the system after everything has been updated.  

```sh
#Clean cache then update then upgrade. 
apt-get clean && apt-get -y update && apt-get -y upgrade
# after the updates, clean and remove the junk. 
apt-get clean && apt -y autoclean && apt -y autoremove
#Restart
systemctl reboot 
```


### Install programs

Check out these programs.  

```sh
#install VLC media player
apt-get install vlc


```









[Back to the top. ⇧](../master/My_Tweaks_and_must_have_programs_for_Kali_Linux.md#my-tweaks-and-must-have-programs-for-kali-linux)  

  
```
```
  

[License](https://github.com/newCodez99/Using-Github/blob/master/LICENSE)

