

## My Tweaks and must have programs for Kali Linux

So you have a fresh Kali installed on your USD flash drive. Lets tweak it a little.  

### Screen Saver

The very first thing you should do is turn off or change the time of the screen saver.  
- We dont want the screen saver going off when we are updating things. 

Go to the setting menu and and turn that thing off.

### New Password

Now change the root password. You have a powerful weapon, lets change the default password so it cant be used against us.  

Open the terminal and type:

```
passwd
```

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

