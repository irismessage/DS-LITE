#!/bin/bash
set -eux
sed -e 's|^|https://archive.org/download/no-ndsdec2022/|' -e 's/$/.zip/' '0-games.txt' > '2-files.txt'
