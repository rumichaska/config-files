# ALIASES

# Configuración git bare repository
alias config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"

# Generales
alias tree="tree --dirsfirst -F"
alias ls="lsd"
alias l="ls -l"
alias la="ls -a"
alias lla="ls -la"
alias lt="ls --tree"
alias s="kitty +kitten ssh"

# R
alias R="R --no-save -q"
alias shinyapp="R -e 'shiny::runApp()'"
