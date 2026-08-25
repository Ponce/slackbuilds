#!/bin/bash

set -eu

if [ "$#" -ne 2 ]; then
  printf 'Usage: %s SOURCE_DIR OUTPUT_DIR\n' "$0" >&2
  exit 1
fi

SOURCE_DIR=$(realpath "$1")
OUTPUT_DIR=$(realpath "$2")

if [ ! -d "$SOURCE_DIR" ] || [ ! -f "$SOURCE_DIR/go.mod" ]; then
  printf 'Invalid source directory: %s\n' "$SOURCE_DIR" >&2
  exit 1
fi

case "$(basename "$SOURCE_DIR")" in
  velero-*) VERSION=${SOURCE_DIR##*/velero-} ;;
  *)
    printf 'Source directory must be named velero-VERSION: %s\n' "$SOURCE_DIR" >&2
    exit 1
    ;;
esac

command -v go >/dev/null 2>&1 || {
  printf 'go not found\n' >&2
  exit 1
}

TMPDIR=$(mktemp -d)
trap 'rm -rf "$TMPDIR"' EXIT

cd "$SOURCE_DIR"
go mod vendor
tar czf "$OUTPUT_DIR/velero-$VERSION-vendor.tar.gz" -C "$SOURCE_DIR" vendor

printf 'Created: %s\n' "$OUTPUT_DIR/velero-$VERSION-vendor.tar.gz"
