#!/bin/bash
set -euo pipefail

NAME="vulners"
VERSION="1.1"    # <-- меняете тут при каждом релизе

BUILD_DIR="/tmp/${NAME}-build"
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR/${NAME}-${VERSION}"

cp -r checks lib vulners LICENSE README.md "$BUILD_DIR/${NAME}-${VERSION}/"

cd "$BUILD_DIR"
tar czf "${NAME}-${VERSION}.tar.gz" "${NAME}-${VERSION}/"
mv "${NAME}-${VERSION}.tar.gz" ~/rpmbuild/SOURCES/

cp "$OLDPWD/packaging/${NAME}.spec" ~/rpmbuild/SPECS/
rpmbuild -ba ~/rpmbuild/SPECS/${NAME}.spec

echo "Готово: ~/rpmbuild/RPMS/noarch/${NAME}-${VERSION}-*.rpm"
