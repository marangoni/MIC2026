#!/usr/bin/env bash
set -euo pipefail

export DISPLAY=:1
export HOME=/home/${USER:-vscode}

WALLPAPER="$HOME/.local/share/backgrounds/wallpaper1.png"

# Aguarda o desktop ficar disponível
for i in {1..30}; do
    if xdpyinfo >/dev/null 2>&1; then
        break
    fi
    sleep 1
done

# Aguarda um pouco mais para o XFCE carregar
sleep 5

# Mostra ícones na área de trabalho
xfconf-query -c xfce4-desktop -p /desktop-icons/style -s 2 || true
xfconf-query -c xfce4-desktop -p /desktop-icons/file-icons/show-home -s true || true
xfconf-query -c xfce4-desktop -p /desktop-icons/file-icons/show-filesystem -s true || true
xfconf-query -c xfce4-desktop -p /desktop-icons/file-icons/show-trash -s true || true
xfconf-query -c xfce4-desktop -p /desktop-icons/file-icons/show-removable -s true || true

# Aplica wallpaper, se existir
if [ -f "$WALLPAPER" ]; then
    # tenta primeiro os caminhos já existentes do xfce4-desktop
    xfconf-query -c xfce4-desktop -l | while read -r prop; do
        case "$prop" in
            */last-image|*/image-path)
                xfconf-query -c xfce4-desktop -p "$prop" -s "$WALLPAPER" || true
                ;;
            */image-style)
                xfconf-query -c xfce4-desktop -p "$prop" -s 5 || true
                ;;
        esac
    done

    # fallback para caminho comum
    xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor0/image-path -s "$WALLPAPER" || true
    xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor0/image-style -s 5 || true
fi

# Recarrega desktop
xfdesktop --reload >/dev/null 2>&1 || true

# Abre um terminal automaticamente, se ainda não houver um
pgrep -f "xfce4-terminal.*MIC2026 Terminal" >/dev/null 2>&1 || \
xfce4-terminal --geometry=100x30+80+80 --title="MIC2026 Terminal" &
