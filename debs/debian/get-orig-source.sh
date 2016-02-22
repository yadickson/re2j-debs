#!/bin/bash

set -ex

PKG="${1}"
VERSION="${2}"
ZIPFILE="${PKG}-${VERSION}.zip"
ORIG_TARBALL="../${PKG}_${VERSION}.orig.tar.xz"

[ ! -f "${ORIG_TARBALL}" ] || exit 0

rm -rf "${PKG}"*
rm -rf "${PKG}-${VERSION}"
rm -f "${ZIPFILE}"

wget -c "https://github.com/google/re2j/archive/${ZIPFILE}" || exit 1

unzip "${ZIPFILE}" || exit 1

rm -f "${ZIPFILE}"

mv "${PKG}"* "${PKG}-${VERSION}"

rm -f "${PKG}-${VERSION}"/*.yml
rm -f "${PKG}-${VERSION}"/.git*
rm -rf "${PKG}-${VERSION}"/javatests
rm -rf "${PKG}-${VERSION}"/testdata

tar -cJf "${ORIG_TARBALL}" --exclude-vcs "${PKG}-${VERSION}" || exit 1

rm -rf "${PKG}-${VERSION}"
rm -f "${ZIPFILE}"

