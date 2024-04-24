#!/bin/bash
set -eux

firmware_dir='firmware'
zip="${firmware_dir}/TWiLightMenu-DSi.7z"
twlm_working="${firmware_dir}/twlm/working"
twlm_new="${firmware_dir}/twlm/new"

disklabel='SANDISK'
mountpoint="/run/media/${USER}/${disklabel}"

# https://wiki.ds-homebrew.com/twilightmenu/updating-dsi.html

# dumb overwrite
# bsdtar \
#     --extract --file "${zip}" \
#     --directory "${mountpoint}" \
#     '_nds' 'BOOT.NDS'

# incremental update
# extract firmware zip to new
mkdir -p "${twlm_new}"
bsdtar \
    --extract --file "${zip}" \
    --directory "${twlm_new}" \
    '_nds' 'BOOT.NDS'

# copy firmware from new to working based on checksums
# this is fast since it happens on the pc
# and it creates a directory with accurate modification times
# based on which files are changed in the update
rsync -avP --checksum "${twlm_new}" "${twlm_working}"

# copy firmware from working to sd card
# this is fast since all it reads from the sd card
# is size and update time metadata
# and it only sends modified files since the last update
rsync -avP "${twlm_working}" "${mountpoint}"
