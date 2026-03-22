FROM mcr.microsoft.com/devcontainers/base:ubuntu-22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Sao_Paulo

RUN apt-get update && apt-get install -y \
    xfce4 \
    xfce4-terminal \
    dbus-x11 \
    tigervnc-standalone-server \
    tigervnc-common \
    novnc \
    websockify \
    xterm \
    wget \
    curl \
    unzip \
    ca-certificates \
    sudo \
    git \
    nano \
    vim \
    && rm -rf /var/lib/apt/lists/*
