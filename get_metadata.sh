#!/bin/bash
curl https://archive.org/metadata/no-ndsdec2022 | python -m json.tool - metadata.json
