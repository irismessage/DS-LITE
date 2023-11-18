#!/bin/bash
set -eux

mkdir -p 'roms'
for zip in zips/*.zip
do
    bsdtar -xf "${zip}" --directory 'roms'
    # echo "" > "${zip}"
done
