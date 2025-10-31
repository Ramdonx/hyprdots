#!/usr/bin/fish

set -e

echo "🎉 Installing dotfiles..."

# Colores para output
set RED '\033[0;31m'
set GREEN '\033[0;32m'
set YELLOW '\033[1;33m'
set NC '\033[0m' # No Color

# Funciones para imprimir mensajes
function info
    echo -e "{$GREEN}✅ {$NC}$argv"
end

function warn
    echo -e "{$YELLOW}⚠️  {$NC}$argv"
end

function error
    echo -e "{$RED}❌ {$NC}$argv"
end

# Verificar que estamos en el directorio correcto
if not test -f "install.fish"
    error "Please run this script from the repository root directory"
    exit 1
end

# Preguntar ruta de origen (por si no es el directorio actual)
set source_dir (pwd)
echo "📁 Source directory: $source_dir"

# Crear directorio de configuraciones si no existe
mkdir -p ~/.config

# Contador para estadísticas
set copied 0
set skipped 0

# Copiar TODO el contenido de .config del repositorio
if test -d ".config"
    info "Copying entire .config directory..."
    
    # Usar rsync para copiar de forma más eficiente y segura
    if command -v rsync >/dev/null
        rsync -av .config/ ~/.config/
        set copied (count (find .config -type f))
    else
        # Fallback a cp
        cp -r .config/* ~/.config/
        set copied (count (find .config -type f))
    end
    
    info "Copied $copied configuration files"
else
    # Si no existe .config, copiar directorios individuales
    warn ".config directory not found, looking for individual config directories..."
    
    for dir in (find . -maxdepth 1 -type d | grep -v '^\.$' | grep -v '\.git' | sed 's|^\./||')
        if test -d "$dir"
            info "Copying $dir..."
            cp -r "$dir" ~/.config/
            set copied (math $copied + 1)
        end
    end
end

# Dar permisos de ejecución a todos los scripts
info "Making scripts executable..."
find ~/.config -name "*.sh" -exec chmod +x {} \; 2>/dev/null || true
find ~/.config -name "*.fish" -exec chmod +x {} \; 2>/dev/null || true
find ~/.config -name "*.py" -exec chmod +x {} \; 2>/dev/null || true

echo ""
info "🎊 Installation completed!"
echo ""
echo "📊 Statistics:"
echo "   - Configurations copied: $copied"
echo "   - Directories processed: "(count (find ~/.config -maxdepth 1 -type d))""
echo ""
echo "📝 Next steps:"
echo "   - Restart Hyprland: hyprctl reload"
echo "   - Restart terminal: exec fish"