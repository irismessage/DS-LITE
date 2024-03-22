#!/bin/bash
set -eux

zip='firmware/TWiLightMenu-DSi.7z'
disklabel='SANDISK'
mountpoint="/run/media/${USER}/${disklabel}"

# https://wiki.ds-homebrew.com/twilightmenu/updating-dsi.html
bsdtar --extract --file "${zip}" --directory "${mountpoint}" '_nds' 'BOOT.NDS'
