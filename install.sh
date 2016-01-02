echo "Welcome! DO NOT RUN THIS FILE AS ADMIN."
git --version 2>&1 >/dev/null
GIT_IS_AVAILABLE=$?
if [ $GIT_IS_AVAILABLE -eq 0 ]; then
    echo "Installing xdgmenumaker..."
else
    echo "Git is not installed. Trying to install git..."
    sudo pacman -S --noconfirm git
fi
#Save current dir
current_dir=$(pwd)

mkdir -p ~/.psytmp/
cd ~/.psytmp/
git clone https://github.com/gapan/xdgmenumaker.git
cd xdgmenumaker
make
sudo make install
echo "Installing necessary xorg and xfce components..."
sudo pacman -S --needed --noconfirm xorg-xprop xorg-xwininfo mousepad xlockmore xorg-xclock xfce4-terminal thunar network-manager-applet pa-applet feh
echo "Copying config files..."
cd "$current_dir"/Config/
cp -a . ~/
echo "Removing temp folder..."
rm -rf ~/.psytmp/
echo "Done! Restarting jwm..."
jwm -restart