#!/usr/bin/env bash

set -euo pipefail

has() { command -v "$1" >/dev/null 2>&1; }

# ==== RIG ====

install_rig() {
        echo "Installing rig..."
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
        RIG_DEB_URL=$(jq -r '.assets[] | select(.name | endswith("amd64.deb")) | .browser_download_url' <<< "$RIG_LATEST_RELEASE")
        RIG_DEB_FILE="$HOME/Downloads/rig_latest.deb"

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
