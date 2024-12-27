#!/bin/bash
set -eux

input="${1}"
# output="${input%.*}.png"
output="${2}"

# size for twilightmenu images
size='208x156'
# size for nds-bootstrap screenshots
#size='256x192'
# arguments for nds-bootstrap screenshots
ndsbargs='-colorspace sRGB -depth 8'

# best thing to do in the long term
# rather than placing custom images in screenshots.tar
# is to extract and convert screenshots.tar into theme images

magick \
    "${input}" \
    -resize "${size}^" \
    -gravity 'Center' \
    -extent "${size}" \
    "${output}"
