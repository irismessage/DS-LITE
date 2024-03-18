#!/bin/bash
set -eux

version="${1:-}"

repo='https://github.com/DS-Homebrew/TWiLightMenu'
file='TWiLightMenu-DSi.7z'
directory='firmware'

if [ -z "$version" ]
then
    url="${repo}/releases/latest/download/${file}"
else
    url="${repo}/releases/download/${version}/${file}"
fi

trash-put -f "${directory}/${file}"
wget \
    --directory-prefix "${directory}" \
    "${url}"
