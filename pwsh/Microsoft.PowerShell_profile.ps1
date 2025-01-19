#Inicializar Starship
Invoke-Expression (&starship init powershell)

# 📦 Cargar NVM en pwsh
$env:NVM_DIR = "$HOME/.nvm"
if (Test-Path "$env:NVM_DIR/nvm.sh") {
    bash -c "source $HOME/.nvm/nvm.sh && nvm use default" | Out-Null
    $nodePath = bash -c "source $HOME/.nvm/nvm.sh && which node" | Out-String
    if ($nodePath) {
        $env:PATH += ":$($nodePath.TrimEnd() | Split-Path)"
    }
}

# 🚀 Función para usar NVM desde pwsh
function nvm { bash -c "source $HOME/.nvm/nvm.sh && nvm $args" }

#establecer editor nano

$env:EDITOR = "nano"

#añadir UV para proyectos de python
$env:PATH += ":/home/charly/.local/bin"
