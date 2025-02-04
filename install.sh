#!/bin/bash

# Ruta al directorio de dotfiles (ajusta si es necesario)
DOTFILES_DIR="$HOME/dotfiles"

# Archivos y directorios a enlazar
declare -A FILES_TO_SYMLINK=(
    ["bash/.bashrc"]="$HOME/.bashrc"
    ["bash/.bash_custom"]="$HOME/.bash_custom"
    ["starship/starship.toml"]="$HOME/.config/starship.toml"
    ["pwsh/Microsoft.PowerShell_profile.ps1"]="$HOME/.config/powershell/Microsoft.PowerShell_profile.ps1"
    ["vscode/settings.json"]="$HOME/.config/Code/User/settings.json"
    ["alacritty/alacritty.yml"]="$HOME/.config/alacritty/alacritty.yml"  # Agregar configuración de Alacritty
)

# Función para crear enlaces simbólicos
create_symlinks() {
    echo "Creando enlaces simbólicos..."
    for src in "${!FILES_TO_SYMLINK[@]}"; do
        src_path="$DOTFILES_DIR/$src"
        dest="${FILES_TO_SYMLINK[$src]}"

        # Crear directorio padre si no existe
        mkdir -p "$(dirname "$dest")"

        # Crear enlace simbólico si el archivo fuente existe
        if [ -f "$src_path" ] || [ -d "$src_path" ]; then
            ln -sf "$src_path" "$dest"
            echo "Enlace creado: $dest → $src_path"
        else
            echo "Advertencia: No se encontró $src_path, enlace omitido."
        fi
    done
}

# Función para instalar extensiones de VSCode
install_vscode_extensions() {
    echo "Instalando extensiones de VSCode..."
    if command -v code >/dev/null 2>&1; then
        while IFS= read -r extension; do
            code --install-extension "$extension" --force
        done < "$DOTFILES_DIR/vscode/extensions.txt"
        echo "Extensiones de VSCode instaladas."
    else
        echo "VSCode no está instalado. Omite instalación de extensiones."
    fi
}

# Función para instalar dependencias
install_dependencies() {
    echo "Instalando dependencias necesarias..."
    
    if ! command -v snap >/dev/null 2>&1; then
        echo "Snap no está instalado. Instalándolo ahora..."
        if command -v apt >/dev/null 2>&1; then
            sudo apt update
            sudo apt install -y snapd
        elif command -v yay >/dev/null 2>&1; then
            yay -S snapd --noconfirm
            sudo systemctl enable --now snapd.socket
        else
            echo "No se puede instalar snap automáticamente. Instálalo manualmente."
            exit 1
        fi
    fi

    # Instalar VSCode desde Snap
    if ! snap list code >/dev/null 2>&1; then
        echo "Instalando VSCode desde Snap..."
        sudo snap install code --classic
    else
        echo "VSCode ya está instalado."
    fi

    # Instalar PowerShell desde Snap
    if ! snap list powershell >/dev/null 2>&1; then
        echo "Instalando PowerShell desde Snap..."
        sudo snap install powershell --classic
    else
        echo "PowerShell ya está instalado."
    fi

    # Instalar Starship
    if ! command -v starship >/dev/null 2>&1; then
        echo "Instalando Starship..."
        curl -sS https://starship.rs/install.sh | sh
    else
        echo "Starship ya está instalado."
    fi

    # Instalar Alacritty
    if ! command -v alacritty >/dev/null 2>&1; then
        echo "Instalando Alacritty..."
        if command -v apt >/dev/null 2>&1; then
            sudo apt install -y alacritty
        elif command -v yay >/dev/null 2>&1; then
            yay -S alacritty --noconfirm
        else
            echo "No se puede instalar Alacritty automáticamente. Instálalo manualmente."
            exit 1
        fi
    else
        echo "Alacritty ya está instalado."
    fi

    # Instalar otras herramientas
    if command -v apt >/dev/null 2>&1; then
        sudo apt install -y vim git
    elif command -v yay >/dev/null 2>&1; then
        yay -S vim git --noconfirm
    else
        echo "No se puede instalar vim y git automáticamente. Instálalos manualmente."
    fi
}

# Función principal
main() {
    echo "Comenzando instalación de dotfiles..."

    # Instalar dependencias
    install_dependencies

    # Crear enlaces simbólicos
    create_symlinks

    # Instalar extensiones de VSCode
    install_vscode_extensions

    echo "Configuración completada."
}

# Ejecutar función principal
main
