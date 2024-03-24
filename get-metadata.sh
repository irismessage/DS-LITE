#!/bin/bash
set -eux

basedir="${1:-nds}"
archiveid=$(jq -r '.archiveid' "${basedir}/source.json")
source="https://archive.org/metadata/${archiveid}"

wget \
    --output-document - \
    "${source}" |
        python -m json.tool - "${basedir}/metadata.json"
