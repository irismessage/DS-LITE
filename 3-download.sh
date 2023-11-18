#!/bin/bash
set -eux
wget --no-clobber --directory-prefix 'zips' --input-file '2-files.txt'
