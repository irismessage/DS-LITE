#!/bin/bash
set -eux

basedir='nds'
archiveid=$(cat "${basedir}/archiveid")
source="https://archive.org/metadata/${archiveid}"

wget \
    --output-document - \
    "${source}" | 
        python -m json.tool - "${basedir}/metadata.json"
