#!/bin/bash

STEAM_CLASS="steam"

# Función para obtener el PID de Steam
get_steam_pid() {
    pgrep -x "steam"
}

# Verificar si alguna ventana de Steam ya está abierta en Hyprland
if hyprctl clients | grep -q "$STEAM_CLASS"; then
    echo "Steam ya está abierto, moviendo al workspace 6..."

    # Obtener el PID de Steam
    STEAM_PID=$(get_steam_pid)

    if [ -n "$STEAM_PID" ]; then
        # Mover todas las ventanas de Steam al workspace 6
        hyprctl dispatch movetoworkspacesilent 6,pid:$STEAM_PID
    fi

    # Cambiar al workspace 6
    hyprctl dispatch workspace 6
else
    echo "Abriendo Steam en workspace 6..."

    # Abrir Steam en segundo plano
    steam &

    # Esperar a que Steam se inicie
    sleep 3

    # Cambiar al workspace 6
    hyprctl dispatch workspace 6
fi
