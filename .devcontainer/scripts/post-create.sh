#!/usr/bin/env bash
set -e

mkdir -p /home/vscode/Desktop
mkdir -p /home/vscode/.config

cp .devcontainer/scripts/start-apps.sh /home/vscode/start-apps.sh 2>/dev/null || true
chmod +x /home/vscode/start-apps.sh 2>/dev/null || true

echo "Ambiente MIC2026 criado com sucesso."
echo "Abra a porta 6080 para acessar o desktop remoto."
echo "Senha do VNC/noVNC: aluno_mic2026"
