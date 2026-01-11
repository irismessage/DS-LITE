#!/bin/bash
set -eux

version="${1:-}"

repo='https://github.com/DS-Homebrew/TWiLightMenu'
directory='firmware/twlm-download'
files=(
    'TWiLightMenu-DSi.7z'
    'AddOn-BetterDSiMenuMusic.7z'
    'AddOn-ExtraUIMusic.7z'
    'AddOn-Multimedia.7z'
    'AddOn-VirtualConsole.7z'
)

if [ -z "$version" ]; then
    # latest version
    base_url="${repo}/releases/latest/download"
else
    # specific version
    base_url="${repo}/releases/download/${version}"
fi

urls=( "${files[@]/#/"${base_url}/"}" )
wget \
    --timestamping \
    --directory-prefix "${directory}" \
    "${urls[@]}"
