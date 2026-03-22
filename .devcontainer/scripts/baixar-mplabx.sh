#!/usr/bin/env bash
set -euo pipefail

URL="https://ww1.microchip.com/downloads/aemDocuments/documents/DEV/ProductDocuments/SoftwareTools/MPLABX-v6.20-linux-installer.tar"
ARQ="MPLABX-v6.20-linux-installer.tar"

echo "Tentando baixar o MPLAB X 6.20..."
if wget -O "$ARQ" "$URL"; then
    echo "Download concluído com sucesso: $ARQ"
else
    echo
    echo "Falha no download direto."
    echo "A Microchip provavelmente bloqueou o acesso via wget (401/403)."
    echo "Baixe pelo navegador e depois execute este script novamente."
    exit 1
fi
