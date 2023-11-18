#!/bin/bash
set -eux
wget --no-clobber --directory-prefix 'roms' --input-file 'files.txt'
