#!/bin/bash

set -eu

usage() {
  printf 'Usage: %s SOURCE_DIR OUTPUT_DIR\n' "$0"
  printf '\n'
  printf 'Generate the fastpotify Cargo vendor archive for SOURCE_DIR.\n'
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
  fastpotify-*) VERSION=${SOURCE_DIR##*/fastpotify-} ;;
  *)
    printf 'Source directory must be named fastpotify-VERSION: %s\n' "$SOURCE_DIR" >&2
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
mkdir -p "$TMPDIR/.cargo"
cargo vendor --locked "$TMPDIR/vendor" > "$TMPDIR/.cargo/config.toml"
sed -i "s|$TMPDIR/vendor|vendor|g" "$TMPDIR/.cargo/config.toml"

# projectm-sys otherwise installs libprojectM into lib64 while looking in lib.
sed -i \
  -e 's/\.define("BUILD_SHARED_LIBS", build_shared_libs); \/\/ static\/dynamic/.define("BUILD_SHARED_LIBS", build_shared_libs)\n            .define("CMAKE_INSTALL_LIBDIR", "lib"); \/\/ static\/dynamic/' \
  -e 's/\.define("BUILD_SHARED_LIBS", build_shared_libs) \/\/ static\/dynamic/.define("BUILD_SHARED_LIBS", build_shared_libs)\n            .define("CMAKE_INSTALL_LIBDIR", "lib") \/\/ static\/dynamic/' \
  -e 's|println!("cargo:rustc-link-search=native={}/lib", dst.display());|println!("cargo:rustc-link-search=native={}/lib", dst.display());\n    println!("cargo:rustc-link-search=native={}/lib64", dst.display());|' \
  "$TMPDIR/vendor/projectm-sys/build.rs"
BUILD_RS_SHA256=$(sha256sum "$TMPDIR/vendor/projectm-sys/build.rs" | cut -d ' ' -f1)
sed -i -E "s|(\"build.rs\":\")[^\"]*|\1$BUILD_RS_SHA256|" \
  "$TMPDIR/vendor/projectm-sys/.cargo-checksum.json"

tar cJf "$OUTPUT_DIR/fastpotify-$VERSION-vendor.tar.xz" \
  -C "$TMPDIR" vendor .cargo/config.toml

printf 'Created: %s\n' "$OUTPUT_DIR/fastpotify-$VERSION-vendor.tar.xz"
