#!/usr/bin/python

from pathlib import Path
from sys import argv
from urllib.parse import quote

from _common import DEFAULT_BASEDIR, PATH_FILES, PATH_GAMES

PATH_ARCHIVEID = "archiveid"
PATH_SUFFIX = "suffix"


def get_url_prefix(basedir: Path) -> str:
    archiveid_path = basedir / PATH_ARCHIVEID
    archiveid = archiveid_path.read_text().strip()
    return f"https://archive.org/download/{archiveid}"


def get_url_suffix(basedir: Path) -> str:
    suffix_path = basedir / PATH_SUFFIX
    suffix = suffix_path.read_text().strip()
    return suffix


def convert(prefix: str, suffix: str, name: str) -> str:
    return f"{prefix}/{quote(name)}.{suffix}"


def main():
    try:
        basedir = Path(argv[1])
    except IndexError:
        basedir = Path(DEFAULT_BASEDIR)
    games_path = basedir / PATH_GAMES
    files_path = basedir / PATH_FILES

    prefix = get_url_prefix(basedir)
    suffix = get_url_suffix(basedir)

    with open(games_path) as in_file, open(files_path, "w") as out_file:
        out_file.writelines(
            convert(prefix, suffix, li.removesuffix("\n")) + "\n"
            for li in in_file.readlines()
        )


if __name__ == "__main__":
    main()
