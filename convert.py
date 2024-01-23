#!/usr/bin/python

import json
from pathlib import Path
from sys import argv
from urllib.parse import quote

from _common import DEFAULT_BASEDIR, PATH_FILES, PATH_GAMES

PATH_SOURCE = "source.json"


def get_template(basedir: Path) -> str:
    source_path = basedir / PATH_SOURCE

    with open(source_path) as file:
        source_dict = json.load(file)
    archiveid = source_dict["archiveid"]
    suffix = source_dict["suffix"]

    return f"https://archive.org/download/{archiveid}/{{name}}{suffix}"


def convert(template: str, name: str) -> str:
    name = quote(name)
    return template.format(name=name)


def main():
    try:
        basedir = Path(argv[1])
    except IndexError:
        basedir = Path(DEFAULT_BASEDIR)
    games_path = basedir / PATH_GAMES
    files_path = basedir / PATH_FILES

    template = get_template(basedir)

    with open(games_path) as in_file, open(files_path, "w") as out_file:
        out_file.writelines(
            convert(template, li.removesuffix("\n")) + "\n"
            for li in in_file.readlines()
        )


if __name__ == "__main__":
    main()
