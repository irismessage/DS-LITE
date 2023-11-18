#!/usr/bin/python

from urllib.parse import quote


def convert(name: str) -> str:
    return f"https://archive.org/download/no-ndsdec2022/{quote(name)}.zip"


with open("games.txt") as in_file, open("files.txt", "w") as out_file:
    out_file.writelines(
        convert(line.removesuffix("\n")) + "\n" for line in in_file.readlines()
    )
