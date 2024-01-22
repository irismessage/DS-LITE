#!/usr/bin/python

from pathlib import Path
from urllib.parse import quote

BASEDIR = Path("nds")
PATH_IN_FILE = BASEDIR / "0-games.txt"
PATH_OUT_FILE = BASEDIR / "2-files.txt"


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
