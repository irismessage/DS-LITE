#!/bin/bash
set -eux
wget --output-document - https://archive.org/metadata/no-ndsdec2022 | python -m json.tool - metadata.json
