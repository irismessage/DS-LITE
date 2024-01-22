#!/usr/bin/python

from pathlib import Path
from urllib.parse import quote

from common import PATH_FILES, PATH_GAMES

BASEDIR = Path("nds")
PATH_IN_FILE = BASEDIR / PATH_GAMES
PATH_OUT_FILE = BASEDIR / PATH_FILES
PATH_ARCHIVEID = BASEDIR / "archiveid"


def get_url_prefix() -> str:
    archiveid = PATH_ARCHIVEID.read_text()
    return f"https://archive.org/download/{archiveid}"


def convert(prefix: str, name: str) -> str:
    return f"{prefix}/{quote(name)}.zip"


def main():
    prefix = get_url_prefix()

    with open(PATH_IN_FILE) as in_file, open(PATH_OUT_FILE, "w") as out_file:
        out_file.writelines(
            convert(prefix, line.removesuffix("\n")) + "\n"
            for line in in_file.readlines()
        )


if __name__ == "__main__":
    main()
