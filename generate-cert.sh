#!/bin/bash
set -e

CERT_DIR="$1"
DOMAIN="$2"
IP="$3"

if [ -z "$CERT_DIR" ] || [ -z "$DOMAIN" ]; then
  echo "Usage: $0 <cert-dir> <domain> [ip]"
  exit 1
fi

mkdir -p "$CERT_DIR"

if ! command -v mkcert >/dev/null 2>&1; then
  echo "mkcert chưa được cài. Hãy cài thủ công trước:"
  echo "sudo apt install -y mkcert"
  exit 1
fi

mkcert -install

if [ -n "$IP" ]; then
  mkcert \
    -cert-file "$CERT_DIR/cert.crt" \
    -key-file "$CERT_DIR/cert.key" \
    "$DOMAIN" "*.$DOMAIN" "$IP" localhost 127.0.0.1
else
  mkcert \
    -cert-file "$CERT_DIR/cert.crt" \
    -key-file "$CERT_DIR/cert.key" \
    "$DOMAIN" "*.$DOMAIN" localhost 127.0.0.1
fi

echo "Created:"
echo "  $CERT_DIR/cert.crt"
echo "  $CERT_DIR/cert.key"