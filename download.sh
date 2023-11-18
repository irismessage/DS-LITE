#!/bin/bash
set -eux
wget --timestamping --directory-prefix 'roms' --input-file 'files.txt'
