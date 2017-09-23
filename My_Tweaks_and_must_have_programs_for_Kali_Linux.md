

## My Tweaks and must have programs for Kali Linux

So you have a fresh persistence enabled Kali Linux installed on your USD flash drive. Lets tweak it a little.  

### Setting Changes

Lets open the main settings menu by selecting the down arrow in the top right hand corner of the screen.  

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

Open the Terminal. Lets change the information, color, and look of the terminal by configuring the Bash prompt. To do this we will need to edit the `.bashrc` file.  
The .bashrc file is a shell script that runs every time you open a new shell.  

I have a handy .bashrc file that can be viewed [HERE.]()  
You are going to want to download it and overwrite it to the bashrc file. ****INLESS I FIND A BETTER WAY TO DO IT****

```
wget the .bashrc file info here****
```




### New Password

Now change the root password. You have a powerful weapon, lets change the default password so it cant be used against us.  

Open the terminal and type:

```
passwd
```

Set your new password.  

### Netwrok changes

By default the network interfaces are down. Lets turn them on.

```
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

```
# Set Network Manager management to true
sed -i ' s/managed=false/managed=true/ ' /etc/NetworkManager/NetworkManager.conf
service network-manager restart
```

And just for fun, Lets enable auto MacChanger.  

Edit the `/etc/default/macchanger` file and change the `ENABLE_ON_POST_UP_DOWN=false` to `true`  

```
# Enable the auto Macchanger
sed -i ' s/ENABLE_ON_POST_UP_DOWN=false/ENABLE_ON_POST_UP_DOWN=true/ ' /etc/default/macchanger
```


### Firefox extensions  

Lets add some Firefox extensions.  
- You will need to be connected the the internet first.  

```
start firefox --new-tab https://extensions.gnome.org/extension/1031/topicons/
firefox --new-tab https://extensions.gnome.org/extension/72/recent-items/
firefox --new-tab https://extensions.gnome.org/extension/779/clipboard-indicator/
```



### Update and Upgrade  

```
apt-get clean && apt-get -y update && apt-get -y dist-upgrade
sleep 1
apt-get clean && apt -y autoremove
```










[Back to the top. ⇧](../master/)  

  
```
```
  

[License](https://github.com/newCodez99/Using-Github/blob/master/LICENSE)

