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
    if [ $FIGLET -eq "0" ]; then
      apt-get install -y figlet
    fi
    if [ $TOILET -eq "0" ]; then
      apt-get install -y toilet
    fi
  else
    echo "no-root"
fi

if [ $FIGLET -eq "1" ]; then
  cp -i ./*.flf /usr/share/figlet/
fi

cp -i ./vimrc ~/.vimrc
mv -i ./vim ~/.vim
cp -i ./bashrc ~/.bashrc
cp -i /notes ~/.notes.txt

echo 'done'
