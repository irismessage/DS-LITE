#!/usr/bin/python

from pathlib import Path
from urllib.parse import quote

from common import PATH_FILES, PATH_GAMES

BASEDIR = Path("nds")
PATH_IN_FILE = BASEDIR / PATH_GAMES
PATH_OUT_FILE = BASEDIR / PATH_FILES


def convert(prefix: str, name: str) -> str:
    return f"{prefix}/{quote(name)}.zip"


def main():
    with open(PATH_IN_FILE) as in_file, open(PATH_OUT_FILE, "w") as out_file:
        out_file.writelines(
            convert(
                "https://archive.org/download/no-ndsdec2022",
                line.removesuffix("\n")
            ) + "\n" for line in in_file.readlines()
        )


if __name__ == "__main__":
    main()
