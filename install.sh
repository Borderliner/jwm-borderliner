echo "Welcome! DO NOT RUN THIS FILE AS ADMIN."
echo "_______________________________________________________________________________"
echo "To change the wallpaper, replace the .wallpaper.png file with your own"
echo "  photo with the same name. This file is in your home folder, and is"
echo "  hidden."
echo "To change the settings, like browser defaults and etc, edit the file"
echo "  '.jwmrc' in your home folder (It's hidden)"
echo "Installing Xfce components is strongly recommended.(Will be propmt later)"
echo "_______________________________________________________________________________"
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
echo "Installing necessary xorg and other components..."
sudo pacman -S --needed --noconfirm xorg-xprop xorg-xwininfo xlockmore xorg-xclock network-manager-applet pa-applet feh
read -p "Should I install some Xfce components? (e.g. Thunar, Orage, Terminal...) (y/n)?" choice
case "$choice" in 
  y|Y|Yes ) sudo pacman -S --needed --noconfirm mousepad xfce4-terminal xfce4-taskmanager thunar orage;;
  n|N|No ) echo "Continuing installation without Xfce components...";;
  * ) echo "Invalid choice, defaulting with NO";;
esac
echo "Copying config files..."
cd "$current_dir"/Config/
cp -a . ~/
echo "Removing temp folder..."
rm -rf ~/.psytmp/
echo "Done! Restarting jwm..."
jwm -restart