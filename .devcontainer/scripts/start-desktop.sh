#!/usr/bin/env bash
set -euo pipefail

USER_HOME="/home/vscode"
DISPLAY_NUM=":1"
VNC_PORT="5901"
NOVNC_PORT="6080"
VNC_PASSWORD="alunomic2026"

mkdir -p "${USER_HOME}/.vnc"

cat > "${USER_HOME}/.vnc/xstartup" <<'EOF'
#!/bin/sh
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
startxfce4
EOF

chmod +x "${USER_HOME}/.vnc/xstartup"

# cria senha do VNC sem interação
printf "%s" "${VNC_PASSWORD}" | vncpasswd -f > "${USER_HOME}/.vnc/passwd"
chmod 600 "${USER_HOME}/.vnc/passwd"

# limpa instâncias antigas
tigervncserver -kill ${DISPLAY_NUM} >/dev/null 2>&1 || true
pkill -f "websockify.*${NOVNC_PORT}" >/dev/null 2>&1 || true
rm -f /tmp/.X1-lock
rm -rf /tmp/.X11-unix/X1

# sobe o VNC só localmente; o acesso externo será pelo noVNC
tigervncserver ${DISPLAY_NUM} \
  -geometry 1440x900 \
  -depth 24 \
  -localhost yes

# publica via noVNC
nohup websockify --web=/usr/share/novnc/ ${NOVNC_PORT} localhost:${VNC_PORT} \
  > "${USER_HOME}/websockify.log" 2>&1 &

echo "Desktop remoto disponível em:"
echo "http://localhost:${NOVNC_PORT}/vnc.html"
echo "Senha do VNC: ${VNC_PASSWORD}"
