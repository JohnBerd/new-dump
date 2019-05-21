is_installed() {
    inst="`which $1`"
}

#installs
apt install vim zsh fonts-powerline terminator chrome-gnome-shell xclip blender git grub-customizer libreoffice

is_installed code
# visual studio code
if [ $inst = "" ]
then
    echo "\e[33m[.]\e[0m Installing visual studio code"
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
    install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
    rm microsoft.gpg
    sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

    sudo apt-get install apt-transport-https
    sudo apt-get update
    apt-install code
fi
is_installed code
if [ $inst != "" ]
then
    echo "\e[32m[+]\e[0m Visual studio code installed"
else
    echo "\e[31m[-]\e[0m Failed to install visual studio code"
fi


#shell
if [ "`cat ~/.zshrc | grep agnoster`" = "" ]
then
    echo "\e[33m[.]\e[0m Installing zsh config"
    chsh -s /bin/zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    sed -i 's/robbyrussell/agnoster/g' ~/.zshrc
    mkdir -p ~/.config/terminator/plugins
    wget https://raw.githubusercontent.com/msudgh/terminator-search/master/terminator_search.py
    mv terminator_search.py ~/.config/terminator/plugins
    cp config ~/.config/terminator/
    mkdir -p ~/.zsh
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh
    echo "source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc
fi

#android-studio
is_installed studio
if [ $inst = "" ]
then
    echo "\e[33m[.]\e[0m Installing android studio"
    wget https://dl.google.com/dl/android/studio/ide-zips/3.4.1.0/android-studio-ide-183.5522156-linux.tar.gz
    tar -xzvf android-studio-ide-183.5522156-linux.tar.gz
    rm android-studio-ide-183.5522156-linux.tar.gz
    mv android-studio /usr/local/bin
    ln -s /usr/local/bin/android-studio/bin/studio.sh /usr/local/bin/studio
fi
is_installed studio
if [ $inst != "" ]
then
    echo "\e[32m[+]\e[0m Android Studio installed"
else
    echo "\e[31m[-]\e[0m Failed to install Android Studio"
fi

#vim
if [ ! -d ~/.vim ]
then
    echo -e "\e[33m[.]\e[0m Installing vim config"
    cp .vimrc ~
    mkdir -p ~/.vim/autoload
    mkdir -p ~/.vim/bundle
    mkdir -p ~/.vim/plugin
    git clone https://github.com/mattn/emmet-vim.git ~/.vim/bundle/
    git clone https://github.com/itchyny/lightline.vim.git ~/.vim/bundle/
    git clone https://github.com/morhetz/gruvbox.git ~/.vim/bundle/
    git clone https://github.com/w0rp/ale.git ~/.vim/bundle/
    git clone https://github.com/stevearc/vim-arduino.git ~/.vim/bundle/
    git clone https://github.com/Townk/vim-autoclose.git ~/.vim/bundle/
fi

#blih
is_installed blih
if [ $inst = "" ]
then
    echo "\e[33m[.]\e[31m Installing blih"
    cp programs/blih /usr/local/bin
fi
is_installed blih
if [ "$inst" != "" ]
then
    echo "\e[32m[+]\e[0m Blih installed"
else
    echo "\e[31m[-]\e[0m Failed to install blih"
fi

#grub-theme
mkdir -p /boot/grub/themes
wget https://bitbucket.org/gemlion/aurora-penguinis/raw/master/Aurora-Penguinis-GRUB2.tar.gz
tar -xzvf Aurora-Penguinis-GRUB2.tar.gz
mv Aurora-Penguinis-GRUB2 /boot/grub/themes
rm Aurora-Penguinis-GRUB2.tar.gz
sed -i '/GRUB_THEME/d' /etc/default/grub
echo "GRUB_THEME=\"/boot/grub/themes/Aurora-Penguinis-GRUB2/theme.txt\"" >> /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

#git
if [ ! -f ~/.ssh/id_rsa.pub ]
then
    echo "\e[33m[.]\e[0m Installing ssh config"
    ssh-keygen
    xclip -sel clip < ~/.ssh/id_rsa.pub
    echo "You can now paste your ssh key in github and blih"
fi
