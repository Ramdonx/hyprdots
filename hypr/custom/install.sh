
### `install.sh`
```bash
#!/bin/bash

echo "🚀 Installing Hyprland configuration..."

# Check if we're on Arch Linux
if ! grep -q "Arch Linux" /etc/os-release 2>/dev/null; then
    echo "❌ This script only works on Arch Linux"
    exit 1
fi

# Create config directory if it doesn't exist
mkdir -p ~/.config/hypr

# Copy configuration files
echo "📁 Copying configuration files..."
cp -r hypr/* ~/.config/hypr/

# Make scripts executable
chmod +x ~/.config/hypr/custom/scripts/*.sh

echo "✅ Configuration installed!"
echo "🔁 Restart Hyprland with: hyprctl reload"