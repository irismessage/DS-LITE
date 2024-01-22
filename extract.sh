#!/bin/bash
set -eux

basedir="${1:-nds}"
source="${basedir}/zips/"
dest="${2:-${basedir}/roms/}"
procs="${3:-1}"

mkdir -p "${dest}"
find "${source}" -name '*.zip' -print0 | 
    xargs --verbose --max-procs="${procs}" --max-args=1 --null \
        bsdtar --keep-old-files --directory "${dest}" -xf
