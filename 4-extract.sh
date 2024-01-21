#!/bin/bash
set -eux

dest='roms/'

mkdir -p "${dest}"
find 'zips/' -name '*.zip' -print0 | 
    xargs --verbose --max-procs=0 --max-args=1 --null \
        bsdtar --keep-old-files --directory "${dest}" -xf
