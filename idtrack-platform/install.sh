#!/usr/bin/env bash
set -euo pipefail

echo ""
echo "======================================="
echo " idTrack Platform Installer"
echo "======================================="
echo ""

### CONFIGURAÇÃO

S3_BUCKET="s3://idbox-debian-img/idtrack"

FILES=(
"overlays/rk3588-rock5b-plus-idtrack-overlay.dts"
"scripts/validate-hardware.sh"
"README.md"
)

TARGET_DIR="idtrack-platform"

### FUNÇÕES

check_command() {
    command -v "$1" >/dev/null 2>&1
}

install_aws_cli() {

    echo "AWS CLI not found. Installing..."

    TMP_DIR=$(mktemp -d)
    cd "$TMP_DIR"

    curl -s "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o awscliv2.zip

    unzip -q awscliv2.zip

    sudo ./aws/install

    cd - >/dev/null

    rm -rf "$TMP_DIR"

    echo "AWS CLI installed."
}

validate_aws_credentials() {

    echo "Validating AWS credentials..."

    if ! aws sts get-caller-identity >/dev/null 2>&1; then
        echo ""
        echo "ERROR: Invalid or missing AWS credentials."
        echo ""
        echo "Please export credentials:"
        echo ""
        echo "export AWS_ACCESS_KEY_ID=XXXX"
        echo "export AWS_SECRET_ACCESS_KEY=XXXX"
        echo ""
        exit 1
    fi

    echo "AWS credentials OK."
}

create_structure() {

    echo "Creating directory structure..."

    mkdir -p "$TARGET_DIR/overlays"
    mkdir -p "$TARGET_DIR/scripts"
}

download_files() {

    echo ""
    echo "Downloading idTrack platform files..."
    echo ""

    for file in "${FILES[@]}"; do

        echo "Downloading $file"

        aws s3 cp \
        "$S3_BUCKET/$file" \
        "$TARGET_DIR/$file"

    done
}

post_install() {

    chmod +x "$TARGET_DIR/scripts/"* || true

    echo ""
    echo "======================================="
    echo " idTrack addon installed successfully"
    echo "======================================="
    echo ""

    echo "Installed to:"
    echo ""
    echo "  $(pwd)/$TARGET_DIR"
    echo ""

    echo "Next steps:"
    echo ""
    echo "1) Enter Dev Container"
    echo ""
    echo "2) Continue build instructions"
    echo ""
}

check_environment() {

    echo "Checking environment..."

    if [ ! -f "Makefile" ] || [ ! -d "src" ]; then
        echo ""
        echo "WARNING:"
        echo ""
        echo "You do not appear to be inside the rsdk directory."
        echo ""
        echo "Recommended location:"
        echo ""
        echo "  ~/rsdk"
        echo ""
    fi
}

### EXECUÇÃO

check_environment

if ! check_command curl; then
    echo "ERROR: curl is required."
    exit 1
fi

if ! check_command aws; then
    install_aws_cli
fi

validate_aws_credentials

create_structure

download_files

post_install