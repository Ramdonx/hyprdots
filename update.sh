#!/usr/bin/fish

echo "🔄 Updating dotfiles repository..."

# Crear directorio .config en el repositorio si no existe
mkdir -p .config

# Copiar TODAS las configuraciones de ~/.config al repositorio
echo "📁 Copying configurations from ~/.config..."
rsync -av ~/.config/ .config/ --exclude='.git' --delete

# Mostrar estadísticas
set updated (count (find .config -type f))
echo "📊 Updated $updated files"

# Hacer commit de los cambios
git add .
git commit -m "Update configurations: "(date "+%Y-%m-%d %H:%M")""
git push

echo "✅ Configurations updated and pushed to GitHub!"