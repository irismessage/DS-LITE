#!/bin/bash
set -eux

basedir='nds'
path_files='files.txt'

wget \
    --no-clobber \
    --directory-prefix "${basedir}/zips/" \
    --input-file "${basedir}/${path_files}"
