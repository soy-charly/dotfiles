# ~/.bashrc

# Activar colores en el prompt
force_color_prompt=yes

# Alias útiles
alias ll='ls -la --color=auto'
alias gs='git status'
alias update='sudo apt update && sudo apt upgrade -y'
alias ..='cd ..'
alias ...='cd ../..'

# Historial
HISTSIZE=1000
HISTFILESIZE=2000
HISTCONTROL=ignoredups:erasedups
shopt -s histappend

# Lenguaje
export LANG=es_ES.UTF-8
export LC_ALL=es_ES.UTF-8

# PATH personalizado
export PATH="$HOME/bin:$PATH"

# Prompt personalizado
PS1='\[\e[1;32m\]\u@\h \[\e[1;34m\]\w \$\[\e[0m\] '

# Starship (opcional, si usas bash con starship)
if command -v starship &> /dev/null; then
  eval "$(starship init bash)"
fi

