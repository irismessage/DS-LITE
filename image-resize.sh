#!/bin/bash
set -eux

input="${1}"
# output="${input%.*}.png"
output="${2}"

size="208x156"

convert \
    "${input}" \
    -resize "${size}^" \
    -gravity 'Center' \
    -extent "${size}" \
    "${output}"
