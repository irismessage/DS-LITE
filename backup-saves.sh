#!/bin/bash
set -eux

rsync \
    -avP \
    --prune-empty-dirs \
    --include '*.ini' \
    --include '*.prv' \
    --include '*.pub' \
    --include '*.sav' \
    --include '*/' \
    --exclude '*' \
    '/run/media/joelm/SANDISK/' \
    'saves/'
