#!/bin/bash
set -euo pipefail

NAME="vulners"
VERSION="1.0"

# Директория, где лежит сам build.sh — то есть корень проекта
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

BUILD_DIR="/tmp/${NAME}-build"
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR/${NAME}-${VERSION}"

cp -r "$SCRIPT_DIR"/checks "$SCRIPT_DIR"/lib "$SCRIPT_DIR"/vulners \
      "$SCRIPT_DIR"/LICENSE "$SCRIPT_DIR"/README.md \
      "$BUILD_DIR/${NAME}-${VERSION}/"

cd "$BUILD_DIR"
tar czf "${NAME}-${VERSION}.tar.gz" "${NAME}-${VERSION}/"
mv "${NAME}-${VERSION}.tar.gz" ~/rpmbuild/SOURCES/

cp "$SCRIPT_DIR/packaging/${NAME}.spec" ~/rpmbuild/SPECS/
rpmbuild -ba ~/rpmbuild/SPECS/${NAME}.spec

echo ""
echo "Готово: ~/rpmbuild/RPMS/noarch/${NAME}-${VERSION}-*.rpm"
echo "Для установки: sudo dnf reinstall ~/rpmbuild/RPMS/noarch/${NAME}-${VERSION}-*.rpm"arch/${NAME}-${VERSION}-*.rpm"
