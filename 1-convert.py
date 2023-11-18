#!/usr/bin/python

from urllib.parse import quote

PATH_IN_FILE = "0-games.txt"
PATH_OUT_FILE = "2-files.txt"


def convert(name: str) -> str:
    return f"https://archive.org/download/no-ndsdec2022/{quote(name)}.zip"


with open(PATH_IN_FILE) as in_file, open(PATH_OUT_FILE, "w") as out_file:
    out_file.writelines(
        convert(line.removesuffix("\n")) + "\n" for line in in_file.readlines()
    )
