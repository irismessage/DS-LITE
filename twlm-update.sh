#!/bin/bash
set -eux

disklabel='SANDISK'
mountpoint="/run/media/${USER}/${disklabel}"

firmware_dir='firmware'
zip="${firmware_dir}/TWiLightMenu-DSi.7z"

twlm_working="${firmware_dir}/twlm/working"
twlm_new="${firmware_dir}/twlm/new"

# guide says to copy over _nds/ and BOOT.NDS
# https://wiki.ds-homebrew.com/twilightmenu/updating-dsi.html
# title/ is just for hiyaCFW
# AP-patched games.txt seems to be just for perusal
# snemul.cfg may need to exist for SNES games to run
#   it's not included in the install guide so that could be an oversight (todo report)
#   however we don't want to replace it on update and overwrite settings
# version.txt is just the version number

DUMB=1
if [ "${DUMB}" -eq 1 ]; then
    # dumb overwrite
    bsdtar \
        --extract --file "${zip}" \
        --directory "${mountpoint}" \
        '_nds' 'BOOT.NDS'
    exit
else
    # incremental update
    # extract firmware zip to new
    mkdir -p "${twlm_new}"
    bsdtar \
        --extract --file "${zip}" \
        --directory "${twlm_new}" \
        '_nds' 'BOOT.NDS' 'version.txt'


    # trailing slashes in src path are needed for correct behaivour
    # see rsync manual

    # copy firmware from new to working based on checksums
    # this is fast since it happens on the pc
    # and it creates a directory with accurate modification times
    # based on which files are changed in the update
    # todo fix: -a (archive) preserves modification time
    #   when that's the opposite of what I want to do
    rsync -avP --checksum "${twlm_new}/" "${twlm_working}"

    # copy firmware from working to sd card
    # this is fast since all it reads from the sd card
    # is size and update time metadata
    # and it only sends modified files since the last update
    rsync -avP "${twlm_working}/" "${mountpoint}"
fi
