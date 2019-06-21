#!/bin/bash

epitech_login="xavier.le-cunff@epitech.eu"
personal_github="https://github.com/JohnBerd"

is_installed() {
    inst="`which $1`"
}

check_updates() {
    apt-get update
    nb_update=`apt-get upgrade -s | grep -P '^\d+ upgraded' | cut -d " " -f1`
    if [ $nb_update -ge 10 ]
    then
        apt-get upgrade
        apt-get -y dist-upgrade
        echo -e ""
        echo -e "\e[33mComputer will reboot in 10 seconds, please rerun the script\e[0m"
        sleep 10
        reboot
    fi  
}

check_root() {
    if [ "$EUID" -ne 0 ]
    then
        echo -e "Please run as root"
        exit
    fi
}

conclusion() {
    is_installed $1
    if [ "$inst" != "" ]
    then
        echo -e "\e[32m[+]\e[0m $1 is now installed"
    else
        echo -e "\e[31m[-]\e[0m Failed to install $1"
    fi
}

check_root
check_updates

#nvidia
if [ "`lspci | grep NVIDIA`" != "" ]
then
    apt install -y ocl-icd-libopencl1 nvidia-driver nvidia-cuda-toolkit
fi

#installs
apt install -y vim cmake build-essential zsh fonts-powerline terminator chrome-gnome-shell xclip blender git grub-customizer libreoffice alacarte grub-customizer freecad gimp fritzing

#arduino
is_installed arduino

if [ $inst = "" ]
then
    wget https://downloads.arduino.cc/arduino-cli/arduino-cli-latest-linux64.tar.bz2
    tar -xjvf arduino-cli-latest-linux64.tar.bz2
    mv arduino-cli-latest-linux64 /usr/local/bin/arduino-cli
    rm arduino-cli-latest-linux64
    pip install esptool
    wget https://downloads.arduino.cc/arduino-1.8.9-linux64.tar.xz
    tar xvJf arduino-1.8.9-linux64.tar.xz
    mv arduino-1.8.9/ /usr/local/bin/
    rm -rf arduino-1.8.9-linux64.tar.xz
    cd /usr/local/bin/arduino-1.8.9/
    ./arduino-linux-setup.sh $USER
    ./install.sh
    ln -s /usr/local/bin/arduino-1.8.9/arduino /usr/local/bin
    arduino-cli core install arduino:avr
fi
conclusion arduino

is_installed mkspiffs
if [ "$inst" = "" ]
then
    git clone https://github.com/igrr/mkspiffs.git
    cd mkspiffs
    git submodule update --init
    ./build_all_configs.sh
    cp mkspiffs /usr/local/bin
    cd ..
    rm -rf mkspiffs
fi
conclusion mkspiffs

is_installed atom
if [ "$inst" = "" ]
then
    wget -qO - https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add -
    sh -c 'echo -e "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list'
    sudo apt-get update
    apt-get install atom
fi
conclusion atom

is_installed google-chrome-stable
if [ "$inst" = "" ]
then
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    apt install ./google-chrome-stable_current_amd64.deb
    rm google-chrome-stable_current_amd64.deb
fi
conclusion google-chrome-stable

is_installed code
# visual studio code
if [ "$inst" = "" ]
then
    echo -e "\e[33m[.]\e[0m Installing visual studio code"
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
    install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
    rm microsoft.gpg
    sh -c 'echo -e "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

    sudo apt-get install apt-transport-https
    sudo apt-get update
    apt install code
fi
conclusion code

#shell
if [ "`cat ~/.zshrc | grep agnoster`" = "" ]
then
    echo -e "\e[33m[.]\e[0m Installing zsh config"
    chsh -s /bin/zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    sed -i 's/robbyrussell/agnoster/g' ~/.zshrc
    mkdir -p ~/.config/terminator/plugins
    wget https://raw.githubusercontent.com/msudgh/terminator-search/master/terminator_search.py
    mv terminator_search.py ~/.config/terminator/plugins
    cp config ~/.config/terminator/
    mkdir -p ~/.zsh
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
    mv zsh-syntax-highlighting ~/.zsh
    echo -e "source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc
    cat .zshbonus >> ~/.zshrc
fi

#android-studio
is_installed studio
if [ "$inst" = "" ]
then
    echo -e "\e[33m[.]\e[0m Installing android studio"
    wget https://dl.google.com/dl/android/studio/ide-zips/3.4.1.0/android-studio-ide-183.5522156-linux.tar.gz
    tar -xzvf android-studio-ide-183.5522156-linux.tar.gz
    rm android-studio-ide-183.5522156-linux.tar.gz
    mv android-studio /usr/local/bin
    ln -s /usr/local/bin/android-studio/bin/studio.sh /usr/local/bin/studio
fi
conclusion studio

#vim
if [ ! -f ~/.vimrc ]
then
    echo -e -e "\e[33m[.]\e[0m Installing vim config"
    git submodule update --init --recursive
    cp .vimrc ~
    cp -r .vim ~
    curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
fi

#blih
is_installed blih
if [ "$inst" = "" ]
then
    echo -e "\e[33m[.]\e[31m Installing blih"
    cp programs/blih /usr/local/bin
fi
conclusion blih

#theme
mkdir -p /boot/grub/themes
if [ "`ls /boot/grub/themes | wc -l`" = "0" ]
then
    mkdir -p /boot/grub/themes
    wget https://bitbucket.org/gemlion/aurora-penguinis/raw/master/Aurora-Penguinis-GRUB2.tar.gz
    tar -xzvf Aurora-Penguinis-GRUB2.tar.gz
    cp assets/background.png Aurora-Penguinis-GRUB2/
    mv Aurora-Penguinis-GRUB2 /boot/grub/themes
    rm Aurora-Penguinis-GRUB2.tar.gz
    sed -i '/GRUB_THEME/d' /etc/default/grub
    echo -e "GRUB_THEME=\"/boot/grub/themes/Aurora-Penguinis-GRUB2/theme.txt\"" >> /etc/default/grub
    grub-mkconfig -o /boot/grub/grub.cfg

    apt install -y libglib2.0-dev-bin imagemagick plymouth plymouth-themes plank
    git clone https://github.com/daniruiz/Flat-Remix
    git clone https://github.com/daniruiz/Flat-Remix-GNOME-theme
    git clone https://github.com/vinceliuice/vimix-gtk-themes.git
    vimix-gtk-themes/Install
    mkdir -p ~/.icons ~/.themes
    mv Flat-Remix/Flat-Remix* ~/.icons
    mv Flat-Remix-GNOME-theme/Flat-Remix* ~/.themes
    rm -rf Flat-Remix Flat-Remix-GNOME-theme vimix-gtk-themes
    gsettings set org.gnome.shell.extensions.user-theme name "Flat-Remix-Miami-fullPanel"
    gsettings set org.gnome.desktop.interface icon-theme "Flat-Remix-Blue"
    gsettings set org.gnome.desktop.background picture-uri "file://$(pwd)/assets/background.jpg"
    gsettings set org.gnome.desktop.interface gtk-theme "vimix-doder"
    
    cp assets/login-background.svg /usr/share/images/desktop-base/
    cp assets/desktop-grub.png /usr/share/images/desktop-base/
    cp -r boot-theme/slash /usr/share/plymouth/themes
    plymouth-set-default-theme -R slash
    sed -i '/GRUB_CMDLINE_LINUX_DEFAULT/d' /etc/default/grub
    echo -e "GRUB_CMDLINE_LINUX_DEFAULT=\"quiet splash\"" >> /etc/default/grub
    update-grub2

    apt purge gnome-shell-extension-dashtodock
    mkdir -p ~/.config/autostart/
    cp plank.desktop ~/.config/autostart/
    cp plank.destop ~/.config/autostart/
    rm -rf ~/.config/plank/dock1
    mv dock1 ~/.config/plank/
fi

#git
if [ ! -f ~/.ssh/id_rsa.pub ]
then
    echo -e "\e[33m[.]\e[0m Installing ssh config"
    ssh-keygen
    xclip -sel clip < ~/.ssh/id_rsa.pub
    blih -u $epitech_login sshkey upload ~/.ssh/id_rsa.pub
    firefox $personnal_github&
    echo -e "You can now paste your ssh key in github"
fi

firefox https://adblockplus.org/fr/&
