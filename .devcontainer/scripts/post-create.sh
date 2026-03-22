#!/usr/bin/env bash
set -euo pipefail

USER_HOME="/home/vscode"
DESKTOP_DIR="${USER_HOME}/Desktop"
AUTOSTART_DIR="${USER_HOME}/.config/autostart"
BACKGROUND_DIR="${USER_HOME}/.local/share/backgrounds"
WORKSPACE_DIR="/workspaces/MIC2026"

WALLPAPER_SRC="${WORKSPACE_DIR}/.devcontainer/assets/wallpaper.png"
WALLPAPER_DST="${BACKGROUND_DIR}/wallpaper.png"
START_APPS_SCRIPT="${WORKSPACE_DIR}/.devcontainer/scripts/start-apps.sh"

mkdir -p "${DESKTOP_DIR}"
mkdir -p "${AUTOSTART_DIR}"
mkdir -p "${BACKGROUND_DIR}"

# Copia wallpaper, se existir
if [ -f "${WALLPAPER_SRC}" ]; then
    cp -f "${WALLPAPER_SRC}" "${WALLPAPER_DST}"
fi

# Atalho: Terminal
cat > "${DESKTOP_DIR}/Terminal.desktop" <<'EOF'
[Desktop Entry]
Version=1.0
Type=Application
Name=Terminal
Comment=Abrir terminal
Exec=xfce4-terminal
Icon=utilities-terminal
Terminal=false
Categories=Utility;
EOF

# Atalho: Examples
cat > "${DESKTOP_DIR}/Examples.desktop" <<'EOF'
[Desktop Entry]
Version=1.0
Type=Application
Name=Examples
Comment=Abrir pasta de exemplos
Exec=xdg-open /workspaces/MIC2026/examples
Icon=folder
Terminal=false
Categories=Utility;
EOF

# Atalho: README
cat > "${DESKTOP_DIR}/README_MIC2026.desktop" <<'EOF'
[Desktop Entry]
Version=1.0
Type=Application
Name=README MIC2026
Comment=Abrir instruções
Exec=xdg-open /workspaces/MIC2026/README.md
Icon=text-x-generic
Terminal=false
Categories=Education;
EOF

# Atalho: MPLAB X
cat > "${DESKTOP_DIR}/MPLABX.desktop" <<'EOF'
[Desktop Entry]
Version=1.0
Type=Application
Name=MPLAB X
Comment=Abrir MPLAB X
Exec=bash -lc 'if [ -x /opt/microchip/mplabx/bin/mplab_ide ]; then /opt/microchip/mplabx/bin/mplab_ide; else xfce4-terminal --hold -e "bash -lc \"echo MPLAB X ainda nao instalado.; read\""; fi'
Icon=applications-development
Terminal=false
Categories=Development;
EOF

# Atalho: SimulIDE
cat > "${DESKTOP_DIR}/SimulIDE.desktop" <<'EOF'
[Desktop Entry]
Version=1.0
Type=Application
Name=SimulIDE
Comment=Abrir SimulIDE
Exec=bash -lc 'if command -v simulide >/dev/null 2>&1; then simulide; else xfce4-terminal --hold -e "bash -lc \"echo SimulIDE ainda nao instalado.; read\""; fi'
Icon=applications-engineering
Terminal=false
Categories=Development;Education;
EOF

# Texto de apoio
cat > "${DESKTOP_DIR}/LEIA-ME.txt" <<'EOF'
MIC2026 - Ambiente AVR

Senha do desktop remoto:
aluno_mic2026

Atalhos disponíveis:
- Terminal
- Examples
- README MIC2026
- MPLAB X
- SimulIDE
EOF

# Permissões
chmod 755 "${DESKTOP_DIR}"/*.desktop || true
chmod 644 "${DESKTOP_DIR}/LEIA-ME.txt" || true

# Marcar atalhos como confiáveis
gio set "${DESKTOP_DIR}/Terminal.desktop" metadata::trusted true || true
gio set "${DESKTOP_DIR}/Examples.desktop" metadata::trusted true || true
gio set "${DESKTOP_DIR}/README_MIC2026.desktop" metadata::trusted true || true
gio set "${DESKTOP_DIR}/MPLABX.desktop" metadata::trusted true || true
gio set "${DESKTOP_DIR}/SimulIDE.desktop" metadata::trusted true || true

# Garantir ownership correto
chown -R vscode:vscode "${DESKTOP_DIR}" "${AUTOSTART_DIR}" "${BACKGROUND_DIR}" || true

# Garantir que o script de autostart exista e seja executável
if [ -f "${START_APPS_SCRIPT}" ]; then
    chmod +x "${START_APPS_SCRIPT}" || true
fi

# Autostart para personalização do XFCE ao abrir a sessão gráfica
cat > "${AUTOSTART_DIR}/mic2026-xfce.desktop" <<EOF
[Desktop Entry]
Type=Application
Version=1.0
Name=MIC2026 XFCE Setup
Comment=Personalização inicial do desktop
Exec=${START_APPS_SCRIPT}
Terminal=false
X-GNOME-Autostart-enabled=true
OnlyShowIn=XFCE;
EOF

chmod 644 "${AUTOSTART_DIR}/mic2026-xfce.desktop" || true
chown vscode:vscode "${AUTOSTART_DIR}/mic2026-xfce.desktop" || true

echo "post-create concluído."
