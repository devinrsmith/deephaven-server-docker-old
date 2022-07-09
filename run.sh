#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

TARGET="${1:-groovy-17}"
TMP="$(mktemp)"

docker buildx bake --load --metadata-file "${TMP}" "${TARGET}"
JQ_STR=".\"${TARGET}\".\"containerimage.digest\""
SHA="$(jq -r ${JQ_STR} "${TMP}")"
rm "${TMP}"

exec docker run --rm -p 10000:10000 "${SHA}"
