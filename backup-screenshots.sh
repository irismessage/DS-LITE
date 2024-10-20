#!/bin/bash
set -eux

# todo put variables like this in common.sh and source it?
# don't like the ambiguous imports with that method very much

# the empty images have these as hash
# they're just all 0 bytes for the same size as a real screenshot
# nds-bootstrap doesn't store a pointer to this, it just checks magic bytes
# see here:
# https://github.com/DS-Homebrew/nds-bootstrap/blob/v1.4.0/retail/cardengine/arm9/source/cardengine.c#L338
MD5_EMPTY_BMP='ada747d43e8d4f442f59b255fcf969ea'
# full of images like screenshotXX.bmp
sd='/run/media/joelm/SANDISK'
tar_name='screenshots.tar'
screenshots_tar="${sd}/_nds/nds-bootstrap/${tar_name}"
# these images will be randomly displayed
# on the top screen.
# overrides displaying screenshots
wallpapers="${sd}/_nds/TWiLightMenu/dsimenu/photos"
backups='screenshots'

# get creation date of tar
tar_creation_date=$(stat --format='%w' "${screenshots_tar}")
tar_date_formatted=$(date --date="${tar_creation_date}" '+%Y%m%dT%H%M%SZ')

# move tar off sd
screenshots_tar_moved="${backups}/${tar_name}"
mkdir -p "${backups}"
mv "${screenshots_tar}" "${screenshots_tar_moved}"

for num in $(seq --equal-width 1 50)
do
    # convert to png
    screenshot_bmp="screenshot${num}.bmp"
    screenshot_png="screenshot-${tar_date_formatted}-${num}.png"
    screenshot_dest="${backups}/${screenshot_png}"
    return_code=0
    bsdtar --to-stdout --extract --file "${screenshots_tar_moved}" "${screenshot_bmp}" | 
        magick convert 'bmp:-' "${screenshot_dest}" ||
            return_code="${?}"
    # break if reached empty screenshot
    if [[ "${return_code}" -ne 0 ]]
    then
        break
    fi
    # otherwise, copy to wallpapers
    ./image-resize.sh "${screenshot_dest}" "${wallpapers}/${screenshot_png}"
done
