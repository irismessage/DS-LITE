#!/bin/bash
set -eux

# the empty images have these
# todo does the firmware store a pointer to the first empt one?
MD5_EMPTY_BMP='ada747d43e8d4f442f59b255fcf969ea'
# full of images like screenshotXX.bmp
bootstrap='_nds/nds-bootstrap/screenshots.tar'
# these images will be randomly displayed
# on the top screen.
# overrides displaying screenshots
wallpapers='_nds/TWiLightMenu/dsimenu/photos'
sd='/run/media/joelm/SANDISK/'
backups='screenshots/'

screenshots_tar="${sd}/${bootstrap}"
tar_creation_date=$(stat --format='%w' "${screenshots_tar}")
tar_date_formatted=$(date --date="${tar_creation_date}" '+%Y-%m-%dT%H:%M:%S')

extract_dest="${backups}/${tar_date_formatted}"
mkdir -p "${extract_dest}"
bsdtar --extract --file "${screenshots_tar}" --directory "${extract_dest}"

# todo remove empty files
# todo convert to png for storage space
