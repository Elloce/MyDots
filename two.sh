#!/bin/sh
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo "Updating system!"
sudo pacman -Syu --noconfirm  # Uncommented for actual system update

qtile=("git" "qtile" "xorg-server" "xorg-apps" "xdg-user-dirs" "lightdm" "alacritty")

packages=(
    # Packages
    "feh" "git" "fzf" "htop" "neovim" "less" "zsh" "npm"
    # Fonts
    "ttf-jetbrains-mono-nerd"
)

missing_packages=()

get_installed() {
    for pkg in "${packages[@]}"; do
        if ! pacman -Q "$pkg" > /dev/null 2>&1; then
            missing_packages+=("$pkg")
        fi
    done
}

install_packages() {
    if [ ${#missing_packages[@]} -eq 0 ]; then
        echo "All packages are already installed!"
    else
        echo "Installing missing packages: ${missing_packages[*]}"
        sudo pacman -S "${missing_packages[@]}" --needed
    fi
}

install_yay() {
    if ! command -v yay > /dev/null 2>&1; then
        echo "Installing yay..."
        git clone https://aur.archlinux.org/yay-bin.git /tmp/yay-bin
        cd /tmp/yay-bin || exit
        makepkg -si --noconfirm
        cd - || exit
        rm -rf /tmp/yay-bin
    else
        echo "yay is already installed."
    fi
}

get_installed
install_packages
install_yay
