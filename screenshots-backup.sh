#!/bin/bash
set -eux

# the empty images have these as hash
# they're just all 0 bytes for the same size as a real screenshot
# nds-bootstrap doesn't store a pointer to this, it just checks magic bytes
# see here:
# https://github.com/DS-Homebrew/nds-bootstrap/blob/v1.4.0/retail/cardengine/arm9/source/cardengine.c#L338
MD5_EMPTY_BMP='ada747d43e8d4f442f59b255fcf969ea'
# full of images like screenshotXX.bmp
bootstrap='_nds/nds-bootstrap/screenshots.tar'
# these images will be randomly displayed
# on the top screen.
# overrides displaying screenshots
wallpapers='_nds/TWiLightMenu/dsimenu/photos'
sd='/run/media/joelm/SANDISK'
backups='screenshots'

screenshots_tar="${sd}/${bootstrap}"
tar_creation_date=$(stat --format='%w' "${screenshots_tar}")
tar_date_formatted=$(date --date="${tar_creation_date}" '+%Y%m%dT%H%M%SZ')

extract_dest="${backups}/${tar_date_formatted}"
mkdir -p "${extract_dest}"
bsdtar --extract --file "${screenshots_tar}" --directory "${extract_dest}"

for screenshot_bmp in "${extract_dest}"/*.bmp
do
    screenshot_png="${screenshot_bmp%%.bmp}.png"
    # convert to png, break if reached empty screenshot
    # if [ ! $(convert "${screenshot_bmp}" "${screenshot_png}") ]
    # then
    #     break
    # fi
    convert "${screenshot_bmp}" "${screenshot_png}" || true
done
rm "${extract_dest}"/*.bmp
