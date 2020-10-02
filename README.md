# rpi_conky

Improved version of Novaspirit's conky script. Newer versions of Conky won't play the old configs due to syntax errors, so this script has been corrected.  
Also, I (Botspot) have improved the colors, as the original colors did not look very good together. Screenshot below:
![screenshot](https://github.com/Botspot/rpi_conky/blob/master/conky_screenshot.png?raw=true)

## To Install:

    sudo apt install -y conky
    wget -O ~/.conkyrc https://raw.githubusercontent.com/Botspot/rpi_conky/master/conkyrc

## To uninstall:

    sudo apt purge -y conky
    rm ~/.conkyrc
