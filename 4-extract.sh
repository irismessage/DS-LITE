#!/bin/bash
set -eux

mkdir -p 'roms/'
find 'zips/' -name '*.zip' -print0 | 
    xargs --verbose --max-procs=0 --max-args=1 --null \
        bsdtar --keep-old-files --directory 'roms/' -xf
