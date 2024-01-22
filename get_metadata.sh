#!/bin/bash
set -eux

basedir='nds'
source='https://archive.org/metadata/no-ndsdec2022'

wget \
    --output-document - \
    "${source}" | 
        python -m json.tool - "${basedir}/metadata.json"
