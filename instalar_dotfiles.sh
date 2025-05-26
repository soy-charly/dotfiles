#!/bin/bash

# Ruta donde están los dotfiles (asumimos que estás dentro del repo clonado)
DOTFILES_DIR="$(pwd)"

echo "📦 Instalando dotfiles desde $DOTFILES_DIR..."

# ZSH
[ -f "$DOTFILES_DIR/.zshrc" ] && cp -v "$DOTFILES_DIR/.zshrc" "$HOME/"

# BASH
[ -f "$DOTFILES_DIR/.bashrc" ] && cp -v "$DOTFILES_DIR/.bashrc" "$HOME/"
[ -f "$DOTFILES_DIR/.bash_profile" ] && cp -v "$DOTFILES_DIR/.bash_profile" "$HOME/"

# Alacritty
mkdir -p "$HOME/.config/alacritty"
[ -f "$DOTFILES_DIR/.config/alacritty/alacritty.yml" ] && cp -v "$DOTFILES_DIR/.config/alacritty/alacritty.yml" "$HOME/.config/alacritty/"

# Starship
mkdir -p "$HOME/.config"
[ -f "$DOTFILES_DIR/.config/starship.toml" ] && cp -v "$DOTFILES_DIR/.config/starship.toml" "$HOME/.config/"

# VSCode
mkdir -p "$HOME/.config/Code/User"
cp -v "$DOTFILES_DIR/.config/Code/User/settings.json" "$HOME/.config/Code/User/" 2>/dev/null
cp -v "$DOTFILES_DIR/.config/Code/User/keybindings.json" "$HOME/.config/Code/User/" 2>/dev/null

# VSCode Snippets (si hay)
if [ -d "$DOTFILES_DIR/.config/Code/User/snippets" ]; then
  cp -vr "$DOTFILES_DIR/.config/Code/User/snippets" "$HOME/.config/Code/User/"
fi

echo "✅ Dotfiles instalados correctamente."
