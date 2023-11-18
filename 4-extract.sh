#!/bin/bash
set -eux

cd roms
for zip in *.zip
do
    bsdtar -xf "${zip}"
    echo "" > "${zip}"
done
