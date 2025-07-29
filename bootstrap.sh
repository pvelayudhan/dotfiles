#!/usr/bin/env bash

# colour coded messages
if [ -t 1 ]; then
  GREEN="\033[32m"
  RED="\033[31m"
  RESET="\033[0m"
else
  GREEN=""
  RED=""
  RESET=""
fi


# write to log file without colour codes
LOGFILE="./bootstrap-install.log"
exec > >(tee >(sed -r "s/\x1B\[[0-9;]*[mK]//g" >> "$LOGFILE")) 2>&1

echo "===== Bootstrap script started at $(date '+%Y-%m-%d %H:%M:%S') ====="

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "This script lives in: $DOTFILES_DIR"

CONFIG_FILE="$DOTFILES_DIR/bootstrap.conf"

# Now you can reference files relative to script location:
echo "Using config file: $CONFIG_FILE"

expand_path() {
    eval echo "$1"
}

check_command() {
    local cmd="$1"
    if command -v "$cmd" >/dev/null 2>&1; then
        echo -e "${GREEN}✓ Successfully installed '$cmd'.${RESET}"
    else
        echo -e "${RED}✗ Failed to install '$cmd'.${RESET}"
        return 1
    fi
}

check_python_module() {
    local module="$1"
    if python3 -c "import $module" >/dev/null 2>&1; then
        echo -e "${GREEN}✓ Successfully installed Python module '$module'.${RESET}"
    else
        echo -e "${RED}✗ Failed to install Python module '$module'.${RESET}"
        return 1
    fi
}

check_font() {
    local font="$1"
    if fc-list | grep -iq "$font" >/dev/null 2>&1; then
        echo -e "${GREEN}✓ Successfully installed '$font'.${RESET}"
    else
        echo -e "${RED}✗ Failed to install '$font'.${RESET}"
        return 1
    fi
}

check_symlink() {
    local expected_src="$1"
    local dest="$2"
    if [ -L "$dest" ]; then
        local actual_src
        actual_src=$(readlink "$dest")
        if [ "$actual_src" = "$expected_src" ]; then
            echo -e "${GREEN}✓ Successfully linked '$dest' → '$expected_src'.${RESET}"
            return 0
        else
            echo -e "${RED}✗ '$dest' is a symlink, but points to '$actual_src' (expected '$expected_src'). Replacing...${RESET}"
            return 1
        fi
    elif [ -e "$dest" ]; then
        echo -e "${RED}✗ '$dest' exists but is not a symlink. Replacing...${RESET}"
        return 1
    else
        echo -e "\033[33m- '$dest' does not exist. Creating symlink...${RESET}"
        return 1
    fi
}


# Parse config sections
readarray -t dnf_packages < <(awk '/^\[dnf\]/ {f=1; next} /^\[/ {f=0} f && $0 !~ /^\s*#/ && NF' "$CONFIG_FILE")
readarray -t custom_installs < <(awk '/^\[custom-install\]/ {f=1; next} /^\[/ {f=0} f && $0 !~ /^\s*#/ && NF' "$CONFIG_FILE")
readarray -t dotfile_items < <(awk '/^\[dotfiles\]/ {f=1; next} /^\[/ {f=0} f && $0 !~ /^\s*#/ && NF' "$CONFIG_FILE")
readarray -t fonts < <(awk '/^\[fonts\]/ {f=1; next} /^\[/ {f=0} f && $0 !~ /^\s*#/ && NF' "$CONFIG_FILE")
should_update_all=$(awk -F "=" '/^\[options\]/ { in_section=1; next } /^\[/ { in_section=0 } in_section && $0 !~ /^[[:space:]]*#/ && $1 ~ /update_all/ { gsub(/ /, "", $2); print $2 }' "$CONFIG_FILE")


# --- Preview ---
echo "This script will do the following tasks:"
if [[ "$should_update_all" == "true" ]]; then
    echo "- Update all packages (sudo dnf -y upgrade)"
else
    echo "- Skipping system update (update_all = false)"
fi
# DNF packages
if [ ${#dnf_packages[@]} -gt 0 ]; then
    echo "- Install DNF packages:"
    for pkg in "${dnf_packages[@]}"; do
        echo "  • $pkg"
    done
else
    echo "- No DNF packages to install."
fi
# Custom installs
if [ ${#custom_installs[@]} -gt 0 ]; then
    echo "- Run custom install logic for:"
    for item in "${custom_installs[@]}"; do
        echo "  • $item"
    done
else
    echo "- No custom installs."
fi
# Dotfiles
if [ ${#dotfile_items[@]} -gt 0 ]; then
    echo "- Link dotfiles for:"
    for item in "${dotfile_items[@]}"; do
        echo "  • $item"
    done
else
    echo "- No dotfiles to link."
fi
# Fonts
if [ ${#fonts[@]} -gt 0 ]; then
    echo "- Install the following fonts:"
    for item in "${fonts[@]}"; do
        echo "  • $item"
    done
else
    echo "- No fonts to install."
fi

echo
read -p "Continue with installation? (y/n): " confirm
if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
    echo "Aborted."
    exit 1
fi

# --- Updating all packages ---
if [[ "$should_update_all" == "true" ]]; then
    echo "Updating all system packages..."
    sudo dnf upgrade -y
fi

# --- Install DNF packages ---
if [[ ${#dnf_packages[@]} -gt 0 ]]; then
    echo "Installing DNF packages..."
    if sudo dnf -y install "${dnf_packages[@]}"; then
        echo -e "${GREEN}✓ All packages installed successfully.${RESET}"
    else
        echo -e "${RED}✗ One or more DNF packages failed to install. Check the log at '$LOGFILE'.${RESET}"
    fi
fi

# --- Custom installs ---
for item in "${custom_installs[@]}"; do
    case "$item" in
        flatpak)
            echo "attempting to installing flatpak..."
            sudo dnf -y install -y flatpak
            flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
            check_command flatpak
            ;;
        kitty)
            echo "attempting to installing kitty terminal..."
            curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin launch=n
            mkdir -p ~/.local/bin
            rm ~/.local/bin/kitt* 2>/dev/null
            ln -is ~/.local/kitty.app/bin/kitt* ~/.local/bin/
            # backup existing kitty config if it's not a symlink
            if [[ -e ~/.config/kitty && ! -L ~/.config/kitty ]]; then
                mv ~/.config/kitty ~/.config/kitty-bak
                echo "Backed up existing ~/.config/kitty to ~/.config/kitty-bak"
            fi
            ln -is "$DOTFILES_DIR/kitty/kitty" ~/.config/kitty
            check_command kitty
            ;;
        lazygit)
            echo "attempting to installing lazygit..."
            mkdir -p ~/applications
            if [ ! -d ~/applications/lazygit/.git ]; then
                git clone https://github.com/jesseduffield/lazygit.git ~/applications/lazygit
            else
                echo "lazygit repo already exists, pulling latest changes"
                    cd ~/applications/lazygit
                    git pull
                cd -
            fi
            cd ~/applications/lazygit
            go install
            cd -
            check_command ~/go/bin/lazygit
            ;;
        live-server)
            sudo npm -g install live-server
            check_command live-server
            ;;
        pynvim)
            pip install --user pynvim
            check_python_module pynvim
            ;;
        rclone)
            sudo -v ; curl https://rclone.org/install.sh | sudo bash
            check_command rclone
            ;;
        sioyek)
            echo "attempting to installing sioyek PDF reader..."
            mkdir -p ~/applications
            cd ~/applications
            # Download and extract
            wget -O sioyek-release-linux.zip https://github.com/ahrm/sioyek/releases/download/sioyek3-alpha0/sioyek-release-linux.zip
            unzip -o sioyek-release-linux.zip -d sioyek
            rm sioyek-release-linux.zip
            # Symlink the executable
            mkdir -p ~/.local/bin
            ln -sf ~/applications/sioyek/Sioyek-x86_64.AppImage ~/.local/bin/sioyek
            check_command sioyek
            ;;
        steam)
            sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
            sudo dnf config-manager --enable fedora-cisco-openh264 -y
            sudo dnf -y install steam
            check_command steam
            ;;
        typst)
            OUTPUT="$HOME/Downloads/typst.tar.xz"
            wget -O "$OUTPUT" https://github.com/typst/typst/releases/download/v0.13.1/typst-x86_64-unknown-linux-musl.tar.xz
            mkdir -p "$HOME/applications"
            tar -xavf "$OUTPUT" -C "$HOME/applications/"
            ln -sf "$HOME/applications/typst-x86_64-unknown-linux-musl/typst" "$HOME/.local/bin/typst"
            rm "$HOME/Downloads/typst.tar.xz"
            check_command typst
            ;;
        ytdlp)
            sudo curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp
            sudo chmod a+rx /usr/local/bin/yt-dlp
            check_command yt-dlp
            ;;
        zotero)
            echo "attempting to installing zotero..."
            URL="https://www.zotero.org/download/client/dl?channel=release&platform=linux-x86_64"
            OUTPUT="$HOME/Downloads/zotero.tar.bz2"
            wget -O "$OUTPUT" "$URL"
            mkdir -p "$HOME/applications"
            tar -xavf "$OUTPUT" -C "$HOME/Downloads/"
            mv -f "$HOME/Downloads/Zotero_linux-x86_64" "$HOME/applications/Zotero_linux-x86_64"
            ln -sf "$HOME/applications/Zotero_linux-x86_64/zotero" "$HOME/.local/bin/zotero"
            rm "$OUTPUT"
            check_command zotero
            ;;
        *)
            echo -e "${RED}✗ No custom install script for '$cmd'.${RESET}"
            ;;
    esac
done

# --- Dotfile symlinks ---
for name in "${dotfile_items[@]}"; do
    echo "Symbolically linking '$name' dotfiles..."
    case "$name" in
        bash)
            targets=(
                "$DOTFILES_DIR/bash/.bashrc:$HOME/.bashrc"
                "$DOTFILES_DIR/bash/.bashrc.d:$HOME/.bashrc.d"
            )
            ;;
        wallpapers)
            mkdir -p "$HOME/Pictures"
            targets=(
                "$DOTFILES_DIR/wallpapers:$HOME/Pictures/wallpapers"
            )
            ;;
        tmux)
            targets=(
                "$DOTFILES_DIR/tmux/.tmux.conf:$HOME/.tmux.conf"
            )
            ;;
        *)
            mkdir -p "$HOME/.config"
            targets=(
                "$DOTFILES_DIR/$name/$name:$HOME/.config/$name"
            )
            ;;
    esac
    for pair in "${targets[@]}"; do
        src="${pair%%:*}"
        dest="${pair##*:}"
        if ! check_symlink "$src" "$dest"; then
            rm -rf -- "$dest"
            ln -s "$src" "$dest"
            check_symlink "$src" "$dest"  # Confirm after creating
        fi
    done
done

for name in "${fonts[@]}"; do
    case "$name" in
        maplemono)
            echo "attempting to install Maple Mono NF font..."
            # Set variables
            URL="https://github.com/subframe7536/maple-font/releases/download/v7.4/MapleMono-NF-unhinted.zip"
            ZIP_NAME="MapleMono-NF-Unhinted.zip"
            TMP_DIR="/tmp/maple-font"
            FONT_DIR="$HOME/.local/share/fonts"
            # Create temp and font directories
            mkdir -p "$TMP_DIR"
            mkdir -p "$FONT_DIR"
            # Download the zip
            echo "Downloading font..."
            curl -L "$URL" -o "$TMP_DIR/$ZIP_NAME"
            # Unzip
            echo "Extracting..."
            unzip -q "$TMP_DIR/$ZIP_NAME" -d "$TMP_DIR"
            # Copy TTF files to the font directory
            echo "Installing fonts..."
            find "$TMP_DIR" -name "*.ttf" -exec cp {} "$FONT_DIR" \;
            # Refresh font cache
            echo "Updating font cache..."
            fc-cache -f "$FONT_DIR"
            # Cleanup
            rm -rf "$TMP_DIR"
            check_font "MapleMono"
            ;;
        *)
            echo "❌ No custom install script defined for: $item"
    esac
done
