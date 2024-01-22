#!/bin/bash
set -eux

basedir='nds/'

wget \
    --no-clobber \
    --directory-prefix "${basedir}/zips/" \
    --input-file "${basedir}/2-files.txt"
