#!/bin/bash
set -eux

disklabel=${1:-SANDISK}
udisksctl unmount -b "/dev/disk/by-label/${disklabel}"
