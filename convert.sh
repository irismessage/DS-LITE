#!/bin/bash
set -eux
sed -e 's|^|https://archive.org/download/no-ndsdec2022/|' -e 's/$/.zip/' 'games.txt' > 'files.txt'
