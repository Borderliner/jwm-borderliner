echo "Welcome! Make sure you run this file as admin.\n"
git --version 2>&1 >/dev/null
GIT_IS_AVAILABLE=$?
if [ $GIT_IS_AVAILABLE -eq 0 ]; then
    echo "Installing xdgmenumaker...\n"
else
    echo "Git is not installed. Trying to install git...\n"
    pacman -S --noconfirm git
fi
#Save current dir
current_dir = $(pwd)

mkdir -p /tmp/.psyringe
cd /tmp/.psyringe
git clone https://github.com/gapan/xdgmenumaker.git
make
make install
echo "Installing necessary xorg components...\n"
pacman -S --needed --noconfirm xorg-xprop xorg-xwininfo mousepad xlockmore xorg-xclock xfce4-terminal thunar network-manager-applet pa-applet
cp $current_dir/Config ~/