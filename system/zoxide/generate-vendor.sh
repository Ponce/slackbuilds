#!/bin/bash

set -eu

usage() {
  printf 'Usage: %s SOURCE_DIR OUTPUT_DIR\n' "$0"
  printf '\n'
  printf 'Generate the zoxide Cargo vendor archive for SOURCE_DIR.\n'
  printf 'SOURCE_DIR must contain Cargo.lock.\n'
}

if [ "$#" -ne 2 ]; then
  usage >&2
  exit 1
fi

SOURCE_DIR=$(realpath "$1")
OUTPUT_DIR=$(realpath "$2")

if [ ! -d "$SOURCE_DIR" ]; then
  printf 'Source directory not found: %s\n' "$SOURCE_DIR" >&2
  exit 1
fi

if [ ! -f "$SOURCE_DIR/Cargo.lock" ]; then
  printf 'Cargo.lock not found in: %s\n' "$SOURCE_DIR" >&2
  exit 1
fi

if [ ! -d "$OUTPUT_DIR" ]; then
  printf 'Output directory not found: %s\n' "$OUTPUT_DIR" >&2
  exit 1
fi

case "$(basename "$SOURCE_DIR")" in
  zoxide-*) VERSION=${SOURCE_DIR##*/zoxide-} ;;
  *)
    printf 'Source directory must be named zoxide-VERSION: %s\n' "$SOURCE_DIR" >&2
    exit 1
    ;;
esac

command -v cargo >/dev/null 2>&1 || {
  printf 'cargo not found\n' >&2
  exit 1
}

TMPDIR=$(mktemp -d)
trap 'rm -rf "$TMPDIR"' EXIT

cd "$SOURCE_DIR"
cargo vendor --locked "$TMPDIR/vendor" >/dev/null

tar czf "$OUTPUT_DIR/zoxide-$VERSION-vendor.tar.gz" \
  -C "$TMPDIR" vendor

printf 'Created: %s\n' "$OUTPUT_DIR/zoxide-$VERSION-vendor.tar.gz"
