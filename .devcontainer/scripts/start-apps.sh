#!/usr/bin/env bash
set -euo pipefail

export DISPLAY=:1
export HOME=/home/${USER:-vscode}

WALLPAPER="$HOME/.local/share/backgrounds/wallpaper1.png"

for i in {1..30}; do
    if xdpyinfo >/dev/null 2>&1; then
        break
    fi
    sleep 1
done

sleep 5

# Sobe componentes do MATE, se ainda não estiverem rodando
pgrep -x mate-settings-daemon >/dev/null 2>&1 || mate-settings-daemon &
pgrep -x marco >/dev/null 2>&1 || marco &
pgrep -x mate-panel >/dev/null 2>&1 || mate-panel &
pgrep -f "caja.*--force-desktop" >/dev/null 2>&1 || caja --force-desktop &

sleep 3

# Aplica wallpaper no MATE
if [ -f "$WALLPAPER" ]; then
    gsettings set org.mate.background picture-filename "$WALLPAPER" || true
    gsettings set org.mate.background picture-options 'scaled' || true
    gsettings set org.mate.background draw-background true || true
fi

# Abre um terminal automaticamente
pgrep -f "mate-terminal.*MIC2026 Terminal" >/dev/null 2>&1 || \
mate-terminal --title="MIC2026 Terminal" &
