#!/bin/bash
set -eux

version="${1:-}"

repo='https://github.com/DS-Homebrew/TWiLightMenu'
file='TWiLightMenu-DSi.7z'
directory='firmware'

if [ -z "$version" ]
then
    # latest version
    url="${repo}/releases/latest/download/${file}"
else
    # specific version
    # delete old one so wget won't refuse to do it
    # if it's older
    trash-put -f "${directory}/${file}"
    url="${repo}/releases/download/${version}/${file}"
fi

wget \
    --timestamping \
    --directory-prefix "${directory}" \
    "${url}"
