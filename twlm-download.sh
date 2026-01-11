#!/bin/bash
set -eux

version="${1:-}"

repo='https://github.com/DS-Homebrew/TWiLightMenu'
file='TWiLightMenu-DSi.7z'
directory='firmware'

if [ -z "$version" ]; then
    # latest version
    base_url="${repo}/releases/latest/download"
else
    # specific version
    base_url="${repo}/releases/download/${version}"
fi

url="${base_url}/${file}"
wget \
    --timestamping \
    --directory-prefix "${directory}" \
    "${url}"
