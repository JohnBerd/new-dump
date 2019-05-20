# visual studio code
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
rm microsoft.gpg
sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

sudo apt-get install apt-transport-https
sudo apt-get update

#installs
apt install vim zsh fonts-powerline terminator chrome-gnome-shell code xclip blender git

#shell
chsh -s /bin/zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
sed -i 's/robbyrussell/agnoster/g' ~/.zshrc
mkdir -p ~/.config/terminator/plugins
wget https://raw.githubusercontent.com/msudgh/terminator-search/master/terminator_search.py
mv terminator_search.py ~/.config/terminator/plugins
cp config ~/.config/terminator/
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
echo "source ${(q-)PWD}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc

#android-studio
wget https://dl.google.com/dl/android/studio/ide-zips/3.4.1.0/android-studio-ide-183.5522156-linux.tar.gz
tar -xzvf android-studio-ide-183.5522156-linux.tar.gz
rm android-studio-ide-183.5522156-linux.tar.gz
mv android-studio /usr/local/bin
ln -s /usr/local/bin/android-studio/bin/studio.sh /usr/local/bin/studio

#vim
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

#git
ssh-keygen
xclip -sel clip < ~/.ssh/id_rsa.pub
