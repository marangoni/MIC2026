FROM mcr.microsoft.com/devcontainers/base:ubuntu-22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Sao_Paulo

RUN apt-get update && apt-get install -y \
    openjdk-17-jre \
    wget \
    curl \
    unzip \
    ca-certificates \
    sudo \
    git \
    nano \
    vim \
    xterm \
    dbus-x11 \
    xdg-utils \
    mate-desktop-environment-core \
    mate-terminal \
    caja \
    marco \
    mate-panel \
    mate-settings-daemon \
    mate-control-center \
    pluma \
    epiphany-browser \
    make \
    gcc \
    g++ \
    gdb \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /opt/installers /opt/microchip /opt/simulide
