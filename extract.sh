#!/bin/bash
set -eux


dest="${1:-roms/}"
procs="${2:-1}"

basedir='nds/'
source="${basedir}/zips/"
dest="${basedir}/"${dest}""

echo "Destination: ${dest}"
echo "Processes: ${procs}"

mkdir -p "${dest}"
find "${source}" -name '*.zip' -print0 | 
    xargs --verbose --max-procs="${procs}" --max-args=1 --null \
        bsdtar --keep-old-files --directory "${dest}" -xf
