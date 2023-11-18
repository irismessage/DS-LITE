#!/bin/bash
set -eux
wget -O - https://archive.org/metadata/no-ndsdec2022 | python -m json.tool - metadata.json
