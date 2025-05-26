# ─────────────────────────────────────────────
# PATH a Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"

# Tema de Zsh (usa Starship, así que comentamos el tema por defecto)
# ZSH_THEME="robbyrussell"

# Plugins activos
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-completions
)

# Inicializar Oh My Zsh
source $ZSH/oh-my-zsh.sh

# ─────────────────────────────────────────────
# Plugins externos (fuera de Oh My Zsh)
# Sugerencias en gris
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=240'

# Syntax Highlighting
source ${(q-)ZSH_CUSTOM:-$ZSH/custom}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Completado extendido
fpath+=(${ZSH_CUSTOM:-$ZSH/custom}/plugins/zsh-completions/src)
autoload -Uz compinit && compinit

# ─────────────────────────────────────────────
# Historial
HISTSIZE=5000
SAVEHIST=5000
HISTFILE=~/.zsh_history
setopt HIST_IGNORE_DUPS          # Ignorar duplicados consecutivos
setopt HIST_IGNORE_ALL_DUPS      # Ignorar duplicados en todo el historial
setopt INC_APPEND_HISTORY        # Añadir comandos inmediatamente
setopt SHARE_HISTORY             # Compartir historial entre sesiones

# ─────────────────────────────────────────────
# Alias útiles
alias ll='ls -la'
alias gs='git status'
alias update='sudo apt update && sudo apt upgrade -y'

# ─────────────────────────────────────────────
# Idioma y localización
export LANG=es_ES.UTF-8
export LC_ALL=es_ES.UTF-8

# ─────────────────────────────────────────────
# Prompt con Starship (recomendado)
eval "$(starship init zsh)"

# ─────────────────────────────────────────────
# PATH personalizado (por si usas ~/bin para scripts)
export PATH="$HOME/bin:$PATH"

# ─────────────────────────────────────────────
# NVM (Node Version Manager)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
