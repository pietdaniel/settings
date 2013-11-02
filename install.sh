#! /bin/bash

# if root check for figlet and toilet install
sudo echo "Please run as root"

if which figlet >/dev/null; then
    FIGLET=1
else
    FIGLET=0
fi

if which toilet >/dev/null; then
    TOILET=1
  else
    TOILET=0
fi

if [ $UID -eq "0" ]; then
    echo "root"
  else
    echo "no-root"
    cp ./vimrc ~/.vimrc
fi

# if not install figlet toilet

# if installed move fonts

# move vimrc

# move vim files

# move bashrc

# update notes
echo 'done'
