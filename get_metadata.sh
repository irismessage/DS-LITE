#!/bin/bash
curl https://archive.org/metadata/no-ndsdec2021 | python -m json.tool - metadata.json
