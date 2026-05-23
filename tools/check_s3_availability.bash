#!/bin/bash
# Copyrigh 2025-2026 Marcus Müller
# SPDX-License-Identifier: GPL-3.0
runname="$1"

bail_with_message() {
  printf '::notice title="%s: %s"::%s\n' "${runname}" "$1" "$2"
  exit 0
}

add_output() {
  printf '%s=%s\n' "$1" "$2" >> "${GITHUB_OUTPUT}"
}

if [[ -n "${S3_CACHE_KEY_ID}" ]] ; then
  add_output HAS_BUCKET_KEY  1
  bail_with_message 'Docker Caching' "enabled caches"
else 
  bail_with_message 'Docker Caching' "disabled caches"
fi
