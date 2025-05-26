#!/bin/bash

# Obtener la ruta absoluta del directorio donde se ejecuta este script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$SCRIPT_DIR/dotfiles_backup"

# Crear carpetas necesarias
mkdir -p "$BACKUP_DIR/.config/Code/User"
mkdir -p "$BACKUP_DIR/.config/alacritty"
mkdir -p "$BACKUP_DIR/.config"

echo "🔄 Copiando dotfiles a $BACKUP_DIR..."

# Shell
cp -v "$HOME/.zshrc" "$BACKUP_DIR/" 2>/dev/null
cp -v "$HOME/.bashrc" "$BACKUP_DIR/" 2>/dev/null
cp -v "$HOME/.bash_profile" "$BACKUP_DIR/" 2>/dev/null

# Alacritty
cp -v "$HOME/.config/alacritty/alacritty.yml" "$BACKUP_DIR/.config/alacritty/" 2>/dev/null

# Starship
cp -v "$HOME/.config/starship.toml" "$BACKUP_DIR/.config/" 2>/dev/null

# VSCode
cp -v "$HOME/.config/Code/User/settings.json" "$BACKUP_DIR/.config/Code/User/" 2>/dev/null
cp -v "$HOME/.config/Code/User/keybindings.json" "$BACKUP_DIR/.config/Code/User/" 2>/dev/null

# VSCode Snippets (si existen)
if [ -d "$HOME/.config/Code/User/snippets" ]; then
    cp -vr "$HOME/.config/Code/User/snippets" "$BACKUP_DIR/.config/Code/User/"
fi

echo "✅ Copia completada. Archivos guardados en: $BACKUP_DIR"

