#!/bin/env bash
# This script simply creates a symbolic link from the files
# in ./xfce to /usr/bin. These are psuedo files to make
# xfce use lightdm as a lockscreen since the default
# one sucks.

# First check if the tools we're replacing are installed.
# They should be uninstalled before running.

for c in "xfce4-screensaver" "slock" "gdmplexiserver"
do
    if command -v "$c" > /dev/null; then
        error=true
        echo "Please uninstall $c before continuing"
    fi

    if [ "$error" == true ]; then
        exit 1
    fi
done

sudo ln -s ~/.local/scripts/xfce/slock /usr/bin
sudo ln -s ~/.local/scripts/xfce/gdmplexiserver /usr/bin
