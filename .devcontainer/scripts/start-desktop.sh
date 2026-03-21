#!/usr/bin/env bash
set -e

export DISPLAY=:1
export VNC_PORT=5901
export NOVNC_PORT=6080

mkdir -p /home/vscode/.vnc

# Inicia display virtual
pgrep -f "Xvfb :1" >/dev/null || Xvfb :1 -screen 0 1440x900x24 &
sleep 2

# Cria xstartup do XFCE para o TigerVNC
cat > /home/vscode/.vnc/xstartup <<'EOF'
#!/bin/sh
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
startxfce4 &
EOF

chmod +x /home/vscode/.vnc/xstartup

# Mata instâncias antigas, se houver
vncserver -kill :1 >/dev/null 2>&1 || true

# Inicia TigerVNC no display :1
vncserver :1 -geometry 1440x900 -depth 24 -localhost no
sleep 2

# Publica via noVNC/websockify
pgrep -f "websockify.*${NOVNC_PORT}" >/dev/null || \
  websockify --web=/usr/share/novnc/ ${NOVNC_PORT} localhost:${VNC_PORT} &
