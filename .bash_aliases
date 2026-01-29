# ALIASES

# Git bare repository configuration
config() {
    /usr/bin/git --git-dir="$HOME/.cfg/" --work-tree="$HOME" "$@"
}

# ls / tree
if command -v lsd >/dev/null 2>&1; then
    alias ls='lsd'
    alias l='ls -l'
    alias la='ls -a'
    alias lla='ls -la'
    alias lt='ls --tree'
else
    alias l='ls -l'
    alias la='ls -a'
    alias lla='ls -la'
fi
command -v tree >/dev/null 2>&1 &&
    alias tree='tree --dirsfirst -F'

# Terminal
command -v kitty >/dev/null 2>&1 &&
    alias s='kitty +kitten ssh'

# R
if command -v R >/dev/null 2>&1; then
    alias R='R --no-save -q'
    alias shinyapp='R -e "shiny::runApp()"'
fi

# Local directories
WORK_MOUNT="/mnt/Trabajo"
share() { cd "$WORK_MOUNT" || return; }
cdcgit() { cd "$WORK_MOUNT/DCG-CDC_GIT_PROJECTS" || return; }
udemy() { cd "$WORK_MOUNT/DCG-CAPACITACIONES/UDEMY_PYTHON" || return; }
