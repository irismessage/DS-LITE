#!/bin/bash
set -eux

dest="${1}"
file="${2}"
stem="$(basename "${file%.*}")"
out="${stem}.nds"

# if dsiware rip contents is just like 00000002,
# replace it with zip name
# idk why no-intro allows that at all
bsdtar \
    --keep-old-files \
    --directory "${dest}" \
    -s "/[0-9]\+/${out}/" \
    -xf "${file}"
