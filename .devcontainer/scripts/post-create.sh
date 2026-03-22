#!/usr/bin/env bash
set -e

mkdir -p /home/vscode/Desktop
mkdir -p /home/vscode/examples

cat > /home/vscode/Desktop/LEIA-ME.txt <<'EOF'
MIC2026 - Ambiente AVR

1. Abra a porta 6080 para acessar o desktop remoto.
2. Senha do VNC/noVNC: aluno_mic2026
3. Os programas MPLAB X e SimulIDE serão adicionados na próxima etapa.
EOF

echo "Ambiente MIC2026 criado com sucesso."
echo "Abra a porta 6080 para acessar o desktop remoto."
echo "Senha do VNC/noVNC: aluno_mic2026"
