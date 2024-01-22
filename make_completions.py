#!/usr/bin/python

import json
from pathlib import Path

BASEDIR = Path("nds/")
COMPLETIONS_DIR = BASEDIR / "completions/"


def list_files() -> list[str]:
    with open("metadata.json") as fp:
        metadata = json.load(fp)
    files = metadata["files"]
    files = [f["name"] for f in files]
    return files


def make_completions(files: list[str]):
    COMPLETIONS_DIR.mkdir(exist_ok=True)
    for f in files:
        COMPLETIONS_DIR.joinpath(f).touch()


def main():
    files = list_files()
    make_completions(files)


if __name__ == "__main__":
    main()
