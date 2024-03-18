#!/bin/bash
set -eux

disklabel=${1:-SANDISK}
udisksctl mount -b "/dev/disk/by-label/${disklabel}"

mountpoint="/run/media/${USER}/${disklabel}"
echo "${mountpoint}"
