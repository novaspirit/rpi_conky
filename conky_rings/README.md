# conky_rings
This is a conky appearance theme that uses a lua script to generate some animated ring graphs.  

Screenshot:  
![conky_screenshot](https://github.com/Botspot/rpi_conky/blob/master/conky_rings/conky_screenshot.png?raw=true)  
Phoenixbyrd from Pi Labs made the original theme, then I [added](https://github.com/Botspot/pi-apps/issues/687#issuecomment-869789919) some color.

## To install manually: 
```
sudo apt install conky-all lua50
wget -O ~/.conky_rings.lua https://raw.githubusercontent.com/Botspot/rpi_conky/master/conky_rings/.conky_rings.lua || error "Failed to download conky-rings.lua!"
wget -O ~/.conkyrc https://raw.githubusercontent.com/Botspot/rpi_conky/master/conky_rings/.conkyrc || error "Failed to get .conkyrc!"
conky -q -d -p 3
```
To make it autostart on boot, create a file at ~/.config/autostart/conky.desktop and place this code into it:
```
[Desktop Entry]
Name=Conky
Type=Application
Exec=bash -c 'sleep 5;conky -q -d -p 3'
Terminal=false
Comment=system monitoring tool.
Categories=Utility;
```
## To uninstall manually:
```
sudo apt purge conky-all lua50
rm ~/.conky_rings.lua ~/.conkyrc ~/.config/autostart/conky.desktop
```
