#!/usr/bin/python

from pathlib import Path
from sys import argv

PATH_IN_FILE = Path("0-games.txt")


def load() -> set[str]:
    with open(PATH_IN_FILE) as in_file:
        games = set(in_file.readlines())
    return games


def save(old: set[str], new: set[str]):
    added = new - old
    with open(PATH_IN_FILE, "a") as in_file:
        in_file.writelines(added)


def add(target: str):
    target = target + "\n"
    games = load()
    if target in games:
        print("Already in there")
        return

    with open(PATH_IN_FILE, "a") as in_file:
        in_file.write()


def main():
    target = Path(argv[1]).stem
    add(target)


if __name__ == "__main__":
    main()
