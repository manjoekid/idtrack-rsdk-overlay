#!/bin/bash
echo "🔥 USING EXTERNAL SCRIPT"
set -e

ROOTFS="$1"

echo "🔧 Installing IDTrack GPIO setup..."

# Resolver caminho do projeto (robusto)
SCRIPT_DIR="$(cd "$(dirname "$0")/.." && pwd)"

# Copiar arquivos
cp -a "$SCRIPT_DIR/files/." "$ROOTFS/"

# Permissões
if [ -f "$ROOTFS/usr/local/bin/idtrack-gpio-init.sh" ]; then
    chmod +x "$ROOTFS/usr/local/bin/idtrack-gpio-init.sh"
fi

# Habilitar serviço (sem systemctl)
mkdir -p "$ROOTFS/etc/systemd/system/multi-user.target.wants"

ln -sf /etc/systemd/system/idtrack-gpio.service \
"$ROOTFS/etc/systemd/system/multi-user.target.wants/idtrack-gpio.service"

echo "✅ IDTrack GPIO setup installed"

echo "🔧 Installing DTB..."

# Detectar kernel
KERNEL_DIR=$(find "$ROOTFS/usr/lib/" -maxdepth 1 -type d -name "linux-image-*" | head -n1)

if [ -z "$KERNEL_DIR" ]; then
    echo "❌ Kernel directory not found!"
    exit 1
fi

DTB_PATH="$KERNEL_DIR/rockchip/rk3588-rock-5b-plus.dtb"
CUSTOM_DTB="$ROOTFS/boot/rk3588-rock-5b-plus-idtrack.dtb"

# Verificar DTB custom
if [ ! -f "$CUSTOM_DTB" ]; then
    echo "❌ Custom DTB not found at $CUSTOM_DTB"
    exit 1
fi

# Garantir diretório
mkdir -p "$(dirname "$DTB_PATH")"

# Backup
if [ -f "$DTB_PATH" ]; then
    cp "$DTB_PATH" "$DTB_PATH.bkp"
fi

# Aplicar DTB
cp "$CUSTOM_DTB" "$DTB_PATH"

echo "✅ DTB installed"

echo "🎯 IDTrack customization completed"