#!/usr/bin/python

from pathlib import Path
from sys import argv

PATH_IN_FILE = "0-games.txt"


def add(target: str):
    with open(PATH_IN_FILE, "a") as in_file:
        in_file.write(target + "\n")


def main():
    target = Path(argv[1]).stem
    add(target)


if __name__ == "__main__":
    main()