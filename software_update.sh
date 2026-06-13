#!/usr/bin/env bash

set -euo pipefail

has() { command -v "$1" >/dev/null 2>&1; }

# ==== RIG ====

install_rig() {
        echo "Installing rig..."
        RIG_DEB_URL=$(jq -r '.assets[] | select(.name | endswith("amd64.deb")) | .browser_download_url' <<< "$RIG_LATEST_RELEASE")
        RIG_DEB_FILE="$HOME/Downloads/rig_latest.deb"
        curl -o "$RIG_DEB_FILE" -L "$RIG_DEB_URL"
        sudo dpkg -i "$RIG_DEB_FILE"
        rm "$RIG_DEB_FILE"
        echo "rig is up to date"
}

RIG_REPO="r-lib/rig"
RIG_GH="https://api.github.com/repos/$RIG_REPO/releases/latest"

RIG_LATEST_RELEASE=$(curl -fsSL "$RIG_GH")
RIG_TAG_NAME=$(jq -r '.tag_name | ltrimstr("v")' <<< "$RIG_LATEST_RELEASE")
RIG_RELEASE_NAME=$(jq -r '.name' <<< "$RIG_LATEST_RELEASE")

if has rig; then
        RIG_CURRENT_VERSION=$(rig --version | grep -Po "(?<=\w )*\d+(\.\d+)*")

        echo "Latest rig release: $RIG_RELEASE_NAME"
        echo "Current rig version: $RIG_CURRENT_VERSION"

        if [[ "$RIG_TAG_NAME" != "$RIG_CURRENT_VERSION" ]]; then
                echo "rig needs update"
                install_rig
        else
                echo "rig is up to date"
        fi
else
        echo "rig is not installed"
        install_rig
fi

# ==== STARSHIP ====

install_staship() {
        echo "Installing Starship..."
        curl -fsSL https://starship.rs/install.sh | sh
        echo "Starship is up to date"
}

STARSHIP_REPO="starship/starship"
STARSHIP_GH="https://api.github.com/repos/$STARSHIP_REPO/releases/latest"

STARSHIP_LATEST_RELEASE=$(curl -fsSL "$STARSHIP_GH")
STARSHIP_TAG_NAME=$(jq -r '.tag_name | ltrimstr("v")' <<< "$STARSHIP_LATEST_RELEASE")
STARSHIP_RELEASE_NAME=$(jq -r '.name' <<< "$STARSHIP_LATEST_RELEASE")

if has starship; then
        STARSHIP_CURRENT_VERSION=$(starship --version | grep -Po "(?<=starship )\d+(\.\d+)*")

        echo "Latest starship release: $STARSHIP_RELEASE_NAME"
        echo "Current starship version: $STARSHIP_CURRENT_VERSION"

        if [[ "$STARSHIP_TAG_NAME" != "$STARSHIP_CURRENT_VERSION" ]]; then
                echo "Starship needs update"
                install_staship
        else
                echo "Starship is up to date"
        fi
else
        echo "Starship is not installed"
        install_staship
fi

# ==== FZF ====

install_fzf() {
        echo "Installing fzf..."
        if [ ! -d "$HOME/.fzf" ]; then
                git clone https://github.com/junegunn/fzf.git "$HOME/.fzf"
        fi
        cd "$HOME/.fzf" && git pull && ./install
        echo "fzf is up to date"
}

FZF_REPO="junegunn/fzf"
FZF_GH="https://api.github.com/repos/$FZF_REPO/releases/latest"

FZF_LATEST_RELEASE=$(curl -fsSL "$FZF_GH")
FZF_TAG_NAME=$(jq -r '.tag_name | ltrimstr("v")' <<< "$FZF_LATEST_RELEASE")
FZF_RELEASE_NAME=$(jq -r '.name' <<< "$FZF_LATEST_RELEASE")

if has fzf; then
        FZF_CURRENT_VERSION=$(fzf --version | awk '{print $1}')

        echo "Latest fzf release: $FZF_RELEASE_NAME"
        echo "Current fzf version: $FZF_CURRENT_VERSION"

        if [[ "$FZF_TAG_NAME" != "$FZF_CURRENT_VERSION" ]]; then
                echo "fzf needs update"
                install_fzf
        else
                echo "fzf is up to date"
        fi
else
        echo "fzf is not installed"
        install_fzf
fi

# ==== BTOP ====

install_btop() {
        echo "Installing btop..."
        BTOP_TAR_URL=$(jq -r '.assets[] | select(.name | startswith("btop-x86_64")) | .browser_download_url' <<< "$BTOP_LATEST_RELEASE")
        BTOP_TAR_FILE="$HOME/Downloads/btop_latest.tar.gz"
        curl -o "$BTOP_TAR_FILE" -L "$BTOP_TAR_URL"
        tar -xvzf "$BTOP_TAR_FILE" -C "$HOME/Downloads"
        cd "$HOME/Downloads/btop"
        sudo make install
        cd "$HOME"
        rm -r "$HOME/Downloads/btop"
        rm "$BTOP_TAR_FILE"
        echo "btop is up to date"
}

BTOP_REPO="aristocratos/btop"
BTOP_GH="https://api.github.com/repos/$BTOP_REPO/releases/latest"

BTOP_LATEST_RELEASE=$(curl -fsSL "$BTOP_GH")
BTOP_TAG_NAME=$(jq -r '.tag_name | ltrimstr("v")' <<< "$BTOP_LATEST_RELEASE")
BTOP_RELEASE_NAME=$(jq -r '.name' <<< "$BTOP_LATEST_RELEASE")

if has btop; then
        BTOP_CURRENT_VERSION=$(btop -v | sed "s/\x1b\[[0-9;]*m//g" | grep -Po "(?<=btop version: )\d+(\.\d+)*")

        echo "Latest btop release: $BTOP_RELEASE_NAME"
        echo "Current btop version: $BTOP_CURRENT_VERSION"

        if [[ "$BTOP_TAG_NAME" != "$BTOP_CURRENT_VERSION" ]]; then
                echo "btop needs update"
                install_btop
        else
                echo "btop is up to date"
        fi
else
        echo "btop is not installed"
        install_btop
fi

# ==== BAT ====

install_bat() {
        echo "Installing bat..."
        BAT_DEB_URL=$(jq -r '.assets[] | select(.name | endswith("_amd64.deb")) | .browser_download_url' <<< "$BAT_LATEST_RELEASE")
        BAT_DEB_FILE="$HOME/Downloads/bat_latest.deb"
        curl -o "$BAT_DEB_FILE" -L "$BAT_DEB_URL"
        sudo dpkg -i "$BAT_DEB_FILE"
        rm "$BAT_DEB_FILE"
        echo "bat is up to date"
}

BAT_REPO="sharkdp/bat"
BAT_GH="https://api.github.com/repos/$BAT_REPO/releases/latest"

BAT_LATEST_RELEASE=$(curl -fsSL "$BAT_GH")
BAT_TAG_NAME=$(jq -r '.tag_name | ltrimstr("v")' <<< "$BAT_LATEST_RELEASE")
BAT_RELEASE_NAME=$(jq -r '.name' <<< "$BAT_LATEST_RELEASE")

if has bat; then
        BAT_CURRENT_VERSION=$(bat --version | grep -Po "(?<=bat )*\d+\.\d+\.\d+")

        echo "Latest bat release: $BAT_RELEASE_NAME"
        echo "Current bat version: $BAT_CURRENT_VERSION"

        if [[ "$BAT_TAG_NAME" != "$BAT_CURRENT_VERSION" ]]; then
                echo "bat needs update"
                install_bat
        else
                echo "bat is up to date"
        fi
else
        echo "bat is not installed"
        install_bat
fi
