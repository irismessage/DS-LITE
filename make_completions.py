#!/usr/bin/python

import json
from pathlib import Path
from sys import argv

from _common import DEFAULT_BASEDIR

DIR_COMPLETIONS = "completions/"
PATH_METADATA = "metadata.json"


def list_files(basedir: Path) -> list[str]:
    metadata_path = basedir / PATH_METADATA

    with open(metadata_path) as fp:
        metadata = json.load(fp)

    files = metadata["files"]
    files = [f["name"] for f in files]
    return files


def make_completions(basedir: Path):
    files = list_files(basedir)

    completions_dir = basedir / DIR_COMPLETIONS

    completions_dir.mkdir(exist_ok=True)
    for f in files:
        completions_dir.joinpath(f).touch()


def main():
    try:
        basedir = Path(argv[1])
    except IndexError:
        basedir = Path(DEFAULT_BASEDIR)

    make_completions(basedir)


if __name__ == "__main__":
    main()
