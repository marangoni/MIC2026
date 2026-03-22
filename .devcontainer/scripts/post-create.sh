#!/usr/bin/env bash
set -e

USER_HOME="/home/vscode"
DESKTOP_DIR="${USER_HOME}/Desktop"
AUTOSTART_DIR="${USER_HOME}/.config/autostart"
WORKSPACE_DIR="/workspaces/MIC2026"

mkdir -p "${DESKTOP_DIR}"
mkdir -p "${AUTOSTART_DIR}"

# -------------------------
# Atalho: Terminal
# -------------------------
cat > "${DESKTOP_DIR}/terminal.desktop" <<'EOF'
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

# -------------------------
# Atalho: Pasta examples
# -------------------------
cat > "${DESKTOP_DIR}/examples.desktop" <<'EOF'
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

# -------------------------
# Atalho: README
# -------------------------
cat > "${DESKTOP_DIR}/readme.desktop" <<'EOF'
[Desktop Entry]
Version=1.0
Type=Application
Name=README MIC2026
Comment=Abrir instruções da disciplina
Exec=xdg-open /workspaces/MIC2026/README.md
Icon=text-x-generic
Terminal=false
Categories=Education;
EOF

# -------------------------
# Atalho: MPLAB X
# -------------------------
cat > "${DESKTOP_DIR}/mplabx.desktop" <<'EOF'
[Desktop Entry]
Version=1.0
Type=Application
Name=MPLAB X
Comment=Abrir MPLAB X IDE
Exec=bash -lc 'if [ -x /opt/microchip/mplabx/bin/mplab_ide ]; then /opt/microchip/mplabx/bin/mplab_ide; else xfce4-terminal --hold -e "bash -lc \"echo MPLAB X ainda nao foi instalado neste ambiente.; read\""; fi'
Icon=applications-development
Terminal=false
Categories=Development;
EOF

# -------------------------
# Atalho: SimulIDE
# -------------------------
cat > "${DESKTOP_DIR}/simulide.desktop" <<'EOF'
[Desktop Entry]
Version=1.0
Type=Application
Name=SimulIDE
Comment=Abrir SimulIDE
Exec=bash -lc 'if command -v simulide >/dev/null 2>&1; then simulide; else xfce4-terminal --hold -e "bash -lc \"echo SimulIDE ainda nao foi instalado neste ambiente.; read\""; fi'
Icon=applications-engineering
Terminal=false
Categories=Education;Development;
EOF

# -------------------------
# Arquivo LEIA-ME na área de trabalho
# -------------------------
cat > "${DESKTOP_DIR}/LEIA-ME.txt" <<'EOF'
MIC2026 - Ambiente AVR

Senha do desktop remoto:
aluno_mic2026

Atalhos:
- Terminal
- Examples
- README MIC2026
- MPLAB X
- SimulIDE

Obs.:
MPLAB X e SimulIDE podem aparecer como "ainda não instalado"
até que sejam adicionados nas próximas etapas.
EOF

# Tornar atalhos executáveis
chmod +x "${DESKTOP_DIR}"/*.desktop

# Confiar nos lançadores
gio set "${DESKTOP_DIR}/terminal.desktop" metadata::trusted true || true
gio set "${DESKTOP_DIR}/examples.desktop" metadata::trusted true || true
gio set "${DESKTOP_DIR}/readme.desktop" metadata::trusted true || true
gio set "${DESKTOP_DIR}/mplabx.desktop" metadata::trusted true || true
gio set "${DESKTOP_DIR}/simulide.desktop" metadata::trusted true || true

# -------------------------
# Autostart: abrir um terminal ao iniciar o desktop
# -------------------------
cat > "${AUTOSTART_DIR}/start-apps.desktop" <<'EOF'
[Desktop Entry]
Type=Application
Name=Start Apps
Exec=/workspaces/MIC2026/.devcontainer/scripts/start-apps.sh
Terminal=false
X-GNOME-Autostart-enabled=true
EOF

echo "Ambiente MIC2026 criado com ícones de desktop."
