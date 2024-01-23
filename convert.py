#!/usr/bin/python

from pathlib import Path
from urllib.parse import quote
from sys import argv

from common import PATH_FILES, PATH_GAMES

try:
    BASEDIR = Path(argv[1])
except IndexError:
    BASEDIR = Path("nds/")
PATH_IN_FILE = BASEDIR / PATH_GAMES
PATH_OUT_FILE = BASEDIR / PATH_FILES
PATH_ARCHIVEID = BASEDIR / "archiveid"
PATH_SUFFIX = BASEDIR / "suffix"


def get_url_prefix() -> str:
    archiveid = PATH_ARCHIVEID.read_text().strip()
    return f"https://archive.org/download/{archiveid}"


def get_url_suffix() -> str:
    suffix = PATH_SUFFIX.read_text().strip()
    return suffix


def convert(prefix: str, suffix: str, name: str) -> str:
    return f"{prefix}/{quote(name)}.{suffix}"


def main():
    prefix = get_url_prefix()
    suffix = get_url_suffix()

    with open(PATH_IN_FILE) as in_file, open(PATH_OUT_FILE, "w") as out_file:
        out_file.writelines(
            convert(prefix, suffix, line.removesuffix("\n")) + "\n"
            for line in in_file.readlines()
        )


if __name__ == "__main__":
    main()
