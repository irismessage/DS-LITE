#!/bin/bash
set -eux

basedir="${1:-nds}"
archiveid=$(cat "${basedir}/archiveid")
source="https://archive.org/metadata/${archiveid}"

wget \
    --output-document - \
    "${source}" | 
        python -m json.tool - "${basedir}/metadata.json"
